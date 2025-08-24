class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.2.tar.gz"
  sha256 "5a9a996dc292cc24dcf411cee87e92f6aae5b8d13bd9c6819b4c7a9dce0818ab"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "251961d1fb21cd100e16d0f56145bc2fa73d560e0e6a09cb597a6ebfba77585a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "791551d751c002dc0fa4b968b66fb7643b60ae575b5f2d09cc3672dd31025054"
    sha256 cellar: :any_skip_relocation, ventura:       "03f38a83d6a1a13bf29ccd61c2e88d56a1339780ba83b7020e61486f42a6679a"
    sha256                               arm64_linux:   "6114539b4b6c517fb661aac53d27682b30c1305bfdd3e91e8ca49b85dedc3f3c"
    sha256                               x86_64_linux:  "a76466525006085166288cab14fb3491b1dadf9ba11ce0c6a85d7b9f291b58e7"
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
