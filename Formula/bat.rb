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
    sha256 cellar: :any_skip_relocation, ventura:      "e5c00a9b6f84095d1e1e835fed5bc591ba2ef6c9bdd8221486874d359b493159"
    sha256 cellar: :any_skip_relocation, monterey:     "16d80646cd5b87a199b455946246777e196f220be44d420a4cbfa42243bb20f5"
    sha256 cellar: :any_skip_relocation, big_sur:      "87570cf37751ff17d1e76ffe446c48fdc6e6f7d59d3d2e78033c7345bd4c1485"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0c6b1d17a67e0b98d2ad0aef78dced608a874f753cfc76c0d31a94858e29fca4"
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
