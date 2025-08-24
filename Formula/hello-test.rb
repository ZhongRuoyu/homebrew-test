class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.2.tar.gz"
  sha256 "5a9a996dc292cc24dcf411cee87e92f6aae5b8d13bd9c6819b4c7a9dce0818ab"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e3f62d9bc2e3b053ee7a368e01ab1db92322439f958b46f1ef8d020d7f206376"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ac826d9f842defb260c1a0a1a01b5cab3947e262a753ef648412066914739966"
    sha256 cellar: :any_skip_relocation, ventura:       "1ada8fec7ae8cdc8f1787079568c0f36f88ed4d09c49fc5ed0542a0c8cf28164"
    sha256                               arm64_linux:   "0e04034f8de50b176770be1968fe602bc241d5ef52914c480ad93542188fde75"
    sha256                               x86_64_linux:  "edc889e636b6607e989c2173ef27c9c7f6425b79335201ba2b5a76caf41a53a2"
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
