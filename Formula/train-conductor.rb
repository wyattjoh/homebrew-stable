class TrainConductor < Formula
  desc "A CLI tool for setting up git worktrees with symlinks and scripts"
  homepage "https://github.com/wyattjoh/train-conductor"
  url "https://github.com/wyattjoh/train-conductor.git",
      tag:      "v0.1.1",
      revision: "00fba0eeb0e1e6d3c720f26f73984018b409fe07"
  license "MIT"
  head "https://github.com/wyattjoh/train-conductor.git", branch: "main"

  depends_on "deno" => :build

  def install
    system "deno", "task", "compile"
    bin.install "train-conductor"
  end

  test do
    assert_match "train-conductor", shell_output("#{bin}/train-conductor --help 2>&1")
  end
end
