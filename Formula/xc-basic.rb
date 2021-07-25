class XcBasic < Formula
  desc "BASIC dialect cross-compiler for the Commodore-64"
  homepage "https://xc-basic.net/"
  url "https://github.com/neilsf/XC-BASIC/archive/refs/tags/v2.3.11.tar.gz"
  sha256 "b771fa7d2d11614a80708ba612b61732e46e8168d2a50c7dcc5a22b0afafeeeb"
  license "MIT"

  depends_on "dmd" => :build
  depends_on "dub" => :build

  def install
    system "dub", "build", "--force", "-v"
    bin.install "xcbasic64"
  end

  test do
    # Compile a simple "hello world" program, and check the prg output & list file
    # exist.
    (testpath/"testfile.bas").write <<~EOS
      PRINT "Hello world"
    EOS
    system "#{bin}/xcbasic64", "testfile.bas", "testfile.prg", "-ltestfile.list"
    assert_predicate testpath/"testfile.prg", :exist?
    assert_predicate testpath/"testfile.list", :exist?
  end
end
