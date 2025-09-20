class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.2.tar.gz"
  sha256 "5a9a996dc292cc24dcf411cee87e92f6aae5b8d13bd9c6819b4c7a9dce0818ab"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3c0a86c9f4355683a7487c27187b1eb6a10dd0db1cb42fb8b9d7a1d98344663b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ef8008f72b7e083785ea2590d0391c83b47c106b217db5ba2e07dd1ff50e0c6d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "14337971597b1d97f500cd9ed7c211a85edf89d424142b5c537262a2f4b60111"
    sha256 cellar: :any_skip_relocation, ventura:       "9cbd274d9012441ad623c24def2cfa2c8c07d4abbae504994d6e23a33f1e161f"
    sha256                               arm64_linux:   "82a470d9bb07150a8d94a67fd218d928d2b1b23f2f254bd87af78d45bf375e73"
    sha256                               x86_64_linux:  "1fe3951dcb58198013a56241847978e73a74ad72c25c514a4de46b855b965d77"
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
