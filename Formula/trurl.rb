class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.8.tar.gz"
  sha256 "7baccde1620062cf8c670121125480269b41bdc81bd4015b7aabe33debb022c6"
  license "curl"
  revision 1
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, ventura:      "43d8a8c85702d61034d484b0023adfd8c9534a726f7f3facff760cf001cd9ed9"
    sha256 cellar: :any,                 monterey:     "fef965bdb7a5efdbcc364e6fd4cc366e939e419a2c0e0593d5503085a4804266"
    sha256 cellar: :any,                 big_sur:      "8da9cbe52305cd4ae0c9aa2d71c5aed7e95fa6d4c107a0ea8711fce21056bc92"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c12087b3e0be83a868d73d7c0e9ae0216012c6107ee2ece92eed9c1f9415bc2e"
  end

  uses_from_macos "curl", since: :ventura # uses CURLUE_NO_ZONEID, available since curl 7.81.0

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    output = shell_output(bin/"trurl https://example.com/hello.html " \
                              "--default-port --get '{scheme} {port} {path}'").chomp
    assert_equal "https 443 /hello.html", output
  end
end
