class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.2.tar.gz"
  sha256 "5a9a996dc292cc24dcf411cee87e92f6aae5b8d13bd9c6819b4c7a9dce0818ab"
  license "GPL-3.0-or-later"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d06f83275de746dbb2145305c261c99d290cf90585fa8565a8c5f3a5e39b2546"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8ca9c92cf12e5ae96e228a4c62b19198add05b46ff002274f3f9e2c0c3b3fb66"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c82e1e9f70ffdd400a58eb138b9b59eb70882c1faf58e2f182f3f48167a5420c"
    sha256 cellar: :any_skip_relocation, sequoia:       "e401c27b2aefb83e48c874b7b1e83cb44eff9b4132625e33ff4d3a74877198f2"
    sha256                               arm64_linux:   "5f4a61cd265006f77709a7646ac18986a68f140c3ad55a46f62496d18be917fa"
    sha256                               x86_64_linux:  "ec7428e7615c117981e5d31f1eea9ec287cf6a6a05bc15a05cd04a3e7640459c"
  end

  def install
    ENV.append "LDFLAGS", "-liconv" if OS.mac?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_equal "brew", shell_output("#{bin}/hello --greeting=brew").chomp
  end
end
