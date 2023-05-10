class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.6.tar.gz"
  sha256 "4564dff7441d33a29aa02fe64bea7ef0809d9fabc1609ac5b50ca5503e81caa6"
  license "curl"
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://github.com/ZhongRuoyu/homebrew-test/releases/download/trurl-0.6"
    sha256 cellar: :any_skip_relocation, ventura:  "cfc040c6a05e289e8a9d5c600f2e0671141a652881db1a752a24232fbcca010c"
    sha256 cellar: :any,                 monterey: "adf9eb8045c343f590a3e5d99ecc96cc1e0ea31335cc4d869d9c39933b5fe60a"
    sha256 cellar: :any,                 big_sur:  "9c3fc3fd14624b8e0771e776098b5c6848cd8c9bfb15ab3023974b26b42b3e6f"
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
