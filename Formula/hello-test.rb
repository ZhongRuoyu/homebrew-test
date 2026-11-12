class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.3.tar.gz"
  sha256 "0d5f60154382fee10b114a1c34e785d8b1f492073ae2d3a6f7b147687b366aa0"
  license "GPL-3.0-or-later"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5260e355becc540ac6088cb3494b085e2f48b53d8c838558b46cf3ef2fdcd5cc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "933544fded060f672761d3cd76581b7a9e19bb5c92d199fa2ac9e8d728392f80"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "d2d9040df93de542ca395f6b2566120ae473cfccd8a18e4aa6968eacf1fda376"
    sha256 cellar: :any_skip_relocation, tahoe:             "e4c7bc22c75edcc50f4756b700e260688afd9837ce5dcd092a9a3cdafd4dbd7e"
    sha256 cellar: :any_skip_relocation, sequoia:           "f43d161676f78048685d0b2683736a2e6ca8c07c75f01ac3990ba54bcc298cb3"
    sha256                               arm64_linux:       "cbcf70b0cc3cab65ce5af13638a78eef1a2024c3cf6a32950e64ca5e4ed21b7c"
    sha256                               x86_64_linux:      "fa831b5d166a380614e83e335f2e53ff6d96b5196db30d68e7f70556a84357cf"
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
