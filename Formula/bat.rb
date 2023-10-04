class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  license any_of: ["Apache-2.0", "MIT"]
  revision 4

  # TODO: Remove `stable` block when we can use unversioned `libgit2`.
  stable do
    # TODO: check if we can use unversioned `libgit2` at version bump.
    # Remove `stable` and `head` blocks when this is done.
    # See comments below for details.
    url "https://github.com/sharkdp/bat/archive/refs/tags/v0.23.0.tar.gz"
    sha256 "30b6256bea0143caebd08256e0a605280afbbc5eef7ce692f84621eb232a9b31"

    # To check for `libgit2` version:
    # 1. Search for `libgit2-sys` version at https://github.com/sharkdp/bat/blob/v#{version}/Cargo.lock
    # 2. If the version suffix of `libgit2-sys` is newer than +1.5.*, then:
    #    - Use the corresponding `libgit2` formula.
    #    - Remove `LIBGIT2_SYS_USE_PKG_CONFIG` env var below.
    #      See: https://github.com/rust-lang/git2-rs/commit/59a81cac9ada22b5ea6ca2841f5bd1229f1dd659.
    depends_on "libgit2@1.5"
  end

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, ventura:      "496ad230b324502ba36383d65d1b5863bb5db1ebfec64cc5c7e1614a75158f7e"
    sha256 cellar: :any_skip_relocation, monterey:     "e4df7333be413379484d3279e51fc8e363ba4abb2c9a0d0a8d2fa1482c0a0599"
    sha256 cellar: :any_skip_relocation, big_sur:      "5d381a1d74612137d1928460bed99c04ca4a97f7c2cb3a0170c7331b79dcceca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "da405d41ea9c555838c41359c8590b578f8fb79882190a3b57e75bb580841446"
  end

  # TODO: Remove `head` block when `stable` uses unversioned `libgit2`.
  head do
    url "https://github.com/sharkdp/bat.git", branch: "master"
    depends_on "libgit2"
  end

  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "oniguruma"

  def install
    ENV["LIBGIT2_NO_VENDOR"] = "1"
    ENV["LIBGIT2_SYS_USE_PKG_CONFIG"] = "1"
    ENV["RUSTONIG_DYNAMIC_LIBONIG"] = "1"
    ENV["RUSTONIG_SYSTEM_LIBONIG"] = "1"

    ENV["SHELL_COMPLETIONS_DIR"] = buildpath
    system "cargo", "install", *std_cargo_args

    assets_dir = Dir["target/release/build/bat-*/out/assets"].first
    man1.install "#{assets_dir}/manual/bat.1"
    bash_completion.install "#{assets_dir}/completions/bat.bash" => "bat"
    fish_completion.install "#{assets_dir}/completions/bat.fish"
    zsh_completion.install "#{assets_dir}/completions/bat.zsh" => "_bat"
  end

  def check_binary_linkage(binary, library)
    binary.dynamically_linked_libraries.any? do |dll|
      next false unless dll.start_with?(HOMEBREW_PREFIX.to_s)

      File.realpath(dll) == File.realpath(library)
    end
  end

  test do
    pdf = test_fixtures("test.pdf")
    output = shell_output("#{bin}/bat #{pdf} --color=never")
    assert_match "Homebrew test", output

    [
      Formula["libgit2@1.5"].opt_lib/shared_library("libgit2"),
      Formula["oniguruma"].opt_lib/shared_library("libonig"),
    ].each do |library|
      assert check_binary_linkage(bin/"bat", library),
             "No linkage with #{library.basename}! Cargo is likely using a vendored version."
    end
  end
end
