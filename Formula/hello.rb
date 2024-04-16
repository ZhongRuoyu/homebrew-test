class Hello < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftp.gnu.org/gnu/hello/hello-2.12.1.tar.gz"
  sha256 "8d99142afd92576f30b0cd7cb42a8dc6809998bc5d607d88761f512e26c7db20"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_sonoma: "47d5337b2212ca2adec3c779fbaf8e5d32b51e6a4e5ff2021c9cbfe5f201eb89"
    sha256 cellar: :any_skip_relocation, ventura:      "418bd5b8c65c9f3d24158db96f5afad26bcf1fdd88a64757ef82285a16bb99cf"
    sha256 cellar: :any_skip_relocation, monterey:     "5c272f45983dc43b8b5d8739969d49c17882d3e19c95218293b4b82ec4045159"
    sha256 cellar: :any_skip_relocation, big_sur:      "44d09b996aedece569e2426887412262f12349121a8d5c6b4695fb20aae6c773"
    sha256                               x86_64_linux: "7ccf130e4bf101ef4bd7765b492bdbc52d26dd5c0a34c1ffe54e7a247167edfe"
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
