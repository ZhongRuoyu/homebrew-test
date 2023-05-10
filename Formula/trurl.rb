class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.6.tar.gz"
  sha256 "4564dff7441d33a29aa02fe64bea7ef0809d9fabc1609ac5b50ca5503e81caa6"
  license "curl"
  revision 1
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://github.com/ZhongRuoyu/homebrew-test/releases/download/trurl-0.6_1"
    sha256 cellar: :any_skip_relocation, ventura:      "ad01053c7bc538f78e5180c5126eb39e238e02a13b9fe9f75c1a61fe4edbf80a"
    sha256 cellar: :any,                 monterey:     "cb50308e40d13b44819af8bb507c6eab37ce182c48e79da21a9f7ef0e816f639"
    sha256 cellar: :any,                 big_sur:      "6303182cf309e674fca693591727c03ff91c2723e10756431f05816688704795"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "af1c401fa649d616caa81f96bcc8b5f8ff72e3daedbcc54f06dafd17916c7151"
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
