class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.13.tar.gz"
  sha256 "8ceeb09d0e08dc677897f26651aa625d9ad18021f881f9d5f31e5a95bb3cc047"
  license "curl"
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "50a7da83883e909d532e5c733d28f8c73fed51508b139f194412357da8c3df1b"
    sha256 cellar: :any_skip_relocation, ventura:      "a2cac4c662840063bfca2445226d6966a693d8d657e8c03f3fc1ad68af3cb7e2"
    sha256 cellar: :any,                 monterey:     "f2f785569b6a5b6e11599e29f67677921c649b8072dc4b24fe36d97971f89de1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "0d5fd0cb634f5b9fea05cd6cd6b57be7ca85dd26f789042e9b863923d94050fb"
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
