class Trurl < Formula
  desc "Command-line tool for URL parsing and manipulation"
  homepage "https://curl.se/trurl/"
  url "https://github.com/curl/trurl/archive/refs/tags/trurl-0.6.tar.gz"
  sha256 "4564dff7441d33a29aa02fe64bea7ef0809d9fabc1609ac5b50ca5503e81caa6"
  license "curl"
  revision 4
  head "https://github.com/curl/trurl.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, ventura:      "018c17543f2d029f3e507640507c80496da1f11e728b0d6bdfaff14206d1fe3b"
    sha256 cellar: :any,                 monterey:     "3ed6275fd242eddb45514199bbab62e5a00f62ea3049bf53be31a058b41174a3"
    sha256 cellar: :any,                 big_sur:      "164baa8b883fa41b0f81fe8cd6debc72e813cb563c77003a0a729498e17368ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "afcb132d9280d3c2bd56ef668f288141c6fcd6c599610c200f0c850a0427d48c"
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
