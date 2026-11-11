class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.3.tar.gz"
  sha256 "0d5f60154382fee10b114a1c34e785d8b1f492073ae2d3a6f7b147687b366aa0"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "37b6a9a908576bbef97ce6f5132a08e568d8abdad9fb3502729d1ad2132c841b"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e87b8cf094605cb5d36ac5a86149bf8eaf9aab001a37743bb36598ea4cb93ea7"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "293ddd7ab5208ba83fd676ade7a830df9e9b4a8682651f29bd6b6d8d3fe19cb9"
    sha256 cellar: :any_skip_relocation, tahoe:             "853a7b6fd7502140ca70bce2e37358f56e1e986d02cbb79ffd5f519fa2bcf96a"
    sha256 cellar: :any_skip_relocation, sequoia:           "4b249de4db4436179cc3ccad670ef8b3245c217509bd25b2f1c52ac6b9ed4f6b"
    sha256                               arm64_linux:       "5f34e05eafb415b52e9ba6acd92d0f2c84c2bdb505b19087fc1e1aeb7dd361ee"
    sha256                               x86_64_linux:      "d6e01d22a290e1192c5d04cfb64d29be836d879046189fbedac80fdd76b1526b"
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
