class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.6.tar.gz"
  sha256 "4564dff7441d33a29aa02fe64bea7ef0809d9fabc1609ac5b50ca5503e81caa6"
  license "curl"
  revision 2
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/test-gh-packages"
    sha256 cellar: :any_skip_relocation, ventura:      "98b18881ba682cff302bfa4932294ce7e1d994a67298f1b5db6b4322241e4f74"
    sha256 cellar: :any,                 monterey:     "88bcaf5d71bc870a8615062343a40a256c40c0dc46f464f0883ce05db1f7acb4"
    sha256 cellar: :any,                 big_sur:      "5a89f0838c21393eb11b2047aaf915f1b4a15418bdc16a0807220942aa3b444a"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d599d87b9077d741d954a136079135aa3af42c15262b9964637fe8ef4c887271"
  end

  uses_from_macos "curl", since: :ventura # uses CURLUE_NO_ZONEID, available since curl 7.81.0

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_equal "https 443 /hello.html",
      shell_output("#{bin}/trurl https://example.com/hello.html --get '{scheme} {port} {path}'").chomp
  end
end
