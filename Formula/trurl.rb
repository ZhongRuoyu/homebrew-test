class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.6.tar.gz"
  sha256 "4564dff7441d33a29aa02fe64bea7ef0809d9fabc1609ac5b50ca5503e81caa6"
  license "curl"
  revision 3
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/test"
    sha256 cellar: :any_skip_relocation, ventura:      "a5a488c2beb091a310aab3782b53037b1f2b2db56196c5a4c7e583a3ff2071f0"
    sha256 cellar: :any,                 monterey:     "68f40e3f585cdb66c2a72792012b46708c45718f0c78abf923dcd5d53ed9fda2"
    sha256 cellar: :any,                 big_sur:      "4afb0d835558c86998bec0613ef4513d378f0d9604c40ffd67d64af29ae0362f"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "42239fa5fa9b88aa0efe70c86bcb761ede38e403d8f25cebc688b78b55ad480a"
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
