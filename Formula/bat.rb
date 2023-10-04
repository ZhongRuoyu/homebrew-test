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
    sha256 cellar: :any,                 ventura:      "471c910bbfca4057572788af05f2d2c854cc23ace93b33da181a30056e1b7f91"
    sha256 cellar: :any,                 monterey:     "acb449b15f6a7604373740bcef203ad0e3c4f63245177b10566f396d16d54255"
    sha256 cellar: :any,                 big_sur:      "089ac277838929413ee4c2556e885997ad5aa33c7f7d2ae791d737352abd01e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "02424b7900ebd5e1ce4399103086b8024f6abc94218f28298e909d693b5c9303"
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
