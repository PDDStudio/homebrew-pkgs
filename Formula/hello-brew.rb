class HelloBrew < Formula
  desc "Simple test formula that prints hello world"
  homepage "https://github.com/pddstudio/hello-brew"
  url ""
  sh256 ""

  bottle :unneeded

  depends_on "bash" => :optional
  depends_on "cake"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end


  test do
    (testpath/"hello-brew.cake").write <<~EOS
      var target = Argument ("target", "info");

      Task("info").Does(() => {
        Information ("Hello, World from the hello-brew command!");
      });

      RunTarget ("info");
    EOS
    assert_match "Hello, World from the hello-brew command!\n", shell_output("#{bin}/cake hello-brew.cake")
  end
end
