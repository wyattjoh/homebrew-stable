class TrainConductor < Formula
  desc "A CLI tool for setting up git worktrees with symlinks and scripts"
  homepage "https://github.com/wyattjoh/train-conductor"
  url "https://github.com/wyattjoh/train-conductor.git",
      tag:      "v0.2.0",
      revision: "c53564cf7183f17dfb692db735a5fb4822bf5418"
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
