class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.3.tar.gz"
  sha256 "0d5f60154382fee10b114a1c34e785d8b1f492073ae2d3a6f7b147687b366aa0"
  license "GPL-3.0-or-later"

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aa691f07c349249c2ab203f408449ea12c580c713826d0f79d40be3f47be7bdb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8a136a30f6c4480c75a47ebdc99a4d8f886ffabe3902e28a393cf7c86ad96529"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6cd0cf45f50727f638d38eb785a92597241be2e13bfd0d6348d557f50a123971"
    sha256 cellar: :any_skip_relocation, tahoe:         "bb53258168da77154c0053c382d28224013ebaa68583c1639cc634c27f88a4e6"
    sha256 cellar: :any_skip_relocation, sequoia:       "f6220f0adf49737076585a1b675c31b0c560df69af9028c4bd46ffc2963c63bd"
    sha256                               arm64_linux:   "700579ea3277342922f9b838dbbf4264ea6bf1ced570a1f55c33e3761ab372cd"
    sha256                               x86_64_linux:  "dfb6e8cd71ab3730ba130516acb962b00f594630020dba012fb6ecefd64893db"
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
