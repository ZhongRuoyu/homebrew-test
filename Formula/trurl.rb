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
    sha256 cellar: :any_skip_relocation, ventura:      "443b404883b4b41842e20052d99c30c8e4200e0770a45915c4b5a0108da932a5"
    sha256 cellar: :any,                 monterey:     "ec73a2e531bfb8d41045a35d31b619dbe06d53adf9c20fb75aee2535df1345ba"
    sha256 cellar: :any,                 big_sur:      "8b50b5178dd055cdcb90673da8b0966bd56a84ae99c995dc9e777c91e6e9e1c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "517b610f5593ba6b799caebed9fdcece9183af85982c5537d5187d93dc3fd606"
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
