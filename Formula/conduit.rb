class Conduit < Formula
  desc "A CLI tool for setting up git worktrees with symlinks and scripts"
  homepage "https://github.com/wyattjoh/conduit"
  url "https://github.com/wyattjoh/conduit.git",
      tag:      "v0.3.0",
      revision: "ab3309d2789a3d8c12b6e2b38d63bfc9ff665474"
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
