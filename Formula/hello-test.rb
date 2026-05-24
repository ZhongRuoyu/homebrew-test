class HelloTest < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/gnu/hello/hello-2.12.2.tar.gz"
  sha256 "5a9a996dc292cc24dcf411cee87e92f6aae5b8d13bd9c6819b4c7a9dce0818ab"
  license "GPL-3.0-or-later"
  revision 2

  bottle do
    root_url "https://ghcr.io/v2/zhongruoyu/zhongruoyu-homebrew-test"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "03333f44b8e6bd007d02c292eaacd4648dd16c798d9a1f0c426021d3d33ec716"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9f1348dfacaf66471f72aae721636c2c7eed802edc5c06f56ea0651005b31bf1"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "35f39af30aed5bf9a930cb4841d8fac43c5ffb990d291ab3e55ddd37c43f5b72"
    sha256 cellar: :any_skip_relocation, tahoe:         "c9af7ee76ac45f786743f07efe396c585921f2fca1bdea76f5fe74bb44972e63"
    sha256 cellar: :any_skip_relocation, sequoia:       "8727ee70ba0f035e56b94e0bbe8ad9b585574c3363fd29ba3134ad430d7bf730"
    sha256                               arm64_linux:   "52adc090cfc512f842e62d49e004d1406cc440c6e233ea8aa51b3494a584f2cd"
    sha256                               x86_64_linux:  "a5de9e6a5ac91d94c90dcf897f158dd7c719def418165faa6d4259ab1c5419cb"
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
