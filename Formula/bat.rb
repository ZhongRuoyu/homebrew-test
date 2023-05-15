class Bat < Formula
  desc "Clone of cat(1) with syntax highlighting and Git integration"
  homepage "https://github.com/sharkdp/bat"
  url "https://github.com/sharkdp/bat/archive/v0.23.0.tar.gz"
  sha256 "30b6256bea0143caebd08256e0a605280afbbc5eef7ce692f84621eb232a9b31"
  license any_of: ["Apache-2.0", "MIT"]
  revision 2
  head "https://github.com/sharkdp/bat.git", branch: "master"

  bottle do
    root_url "https://github.com/ZhongRuoyu/homebrew-test/releases/download/bat-0.23.0_1"
    sha256 cellar: :any_skip_relocation, ventura:      "2f86da5a9e6a2be3f9d4ce4eec3a61b68bc2420353d753df83290ce2496aa57b"
    sha256 cellar: :any_skip_relocation, monterey:     "121592979a58cbf7efef8a2abd6711919bf94b3a0e4e6a0e0345ac1ca7634c4f"
    sha256 cellar: :any_skip_relocation, big_sur:      "c47c29e99f81995144328934395acc7d5ad8da6b3913fa462373a20b5b2fc4b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f021448900c305ae0a9bec5032734d31f607917f04eaa2f9ba1eac8da3e0417b"
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
