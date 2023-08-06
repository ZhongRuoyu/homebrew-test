class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  url "https://github.com/sharkdp/bat/archive/v0.23.0.tar.gz"
  sha256 "30b6256bea0143caebd08256e0a605280afbbc5eef7ce692f84621eb232a9b31"
  license any_of: ["Apache-2.0", "MIT"]
  revision 3
  head "https://github.com/sharkdp/bat.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, ventura:      "496ad230b324502ba36383d65d1b5863bb5db1ebfec64cc5c7e1614a75158f7e"
    sha256 cellar: :any_skip_relocation, monterey:     "e4df7333be413379484d3279e51fc8e363ba4abb2c9a0d0a8d2fa1482c0a0599"
    sha256 cellar: :any_skip_relocation, big_sur:      "5d381a1d74612137d1928460bed99c04ca4a97f7c2cb3a0170c7331b79dcceca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "da405d41ea9c555838c41359c8590b578f8fb79882190a3b57e75bb580841446"
  end

  depends_on "rust" => :build

  uses_from_macos "zlib"

  def install
    ENV["SHELL_COMPLETIONS_DIR"] = buildpath
    system "cargo", "install", *std_cargo_args

    assets_dir = Dir["target/release/build/bat-*/out/assets"].first
    man1.install "#{assets_dir}/manual/bat.1"
    bash_completion.install "#{assets_dir}/completions/bat.bash" => "bat"
    fish_completion.install "#{assets_dir}/completions/bat.fish"
    zsh_completion.install "#{assets_dir}/completions/bat.zsh" => "_bat"
  end

  test do
    pdf = test_fixtures("test.pdf")
    output = shell_output("#{bin}/bat #{pdf} --color=never")
    assert_match "Homebrew test", output
  end
end
