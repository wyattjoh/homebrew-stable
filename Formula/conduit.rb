class Conduit < Formula
  desc "A CLI tool for setting up git worktrees with symlinks and scripts"
  homepage "https://github.com/wyattjoh/conduit"
  url "https://github.com/wyattjoh/conduit.git",
      tag:      "v0.4.0",
      revision: "0848ecf4383b509e60a020e128858d8cb9c403f3"
  license "MIT"
  head "https://github.com/wyattjoh/conduit.git", branch: "main"

  depends_on "deno" => :build

  def install
    system "deno", "task", "compile"
    bin.install "conduit"
  end

  test do
    assert_match "conduit", shell_output("#{bin}/conduit --help 2>&1")
  end
end
