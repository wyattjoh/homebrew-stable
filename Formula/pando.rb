# frozen_string_literal: true

# Formula for the pando Git worktree CLI.
class Pando < Formula
  desc "Inspect and switch between Git worktrees"
  homepage "https://github.com/wyattjoh/pando"
  url "https://github.com/wyattjoh/pando/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "dbdf16d3f290cfb8c4a7b721702ed30b8fc728c357bc7d6a44a9a21fb7bec66f"
  license "MIT"
  head "https://github.com/wyattjoh/pando.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    bin.install_symlink bin/"pando" => "pd"
  end

  test do
    system "git", "init", "--quiet", "--initial-branch=main"
    system "git", "-c", "user.name=Homebrew",
           "-c", "user.email=brew@example.com",
           "-c", "commit.gpgsign=false",
           "commit", "--quiet", "--allow-empty", "-m", "initial"

    output = shell_output("#{bin}/pando list --output json")
    assert_match "\"command\":\"list\"", output
    assert_match "\"status\":\"success\"", output
    assert_match "\"total\":1", output
    assert_equal output, shell_output("#{bin}/pd list --output json")
    assert_match "pando #{version}", shell_output("#{bin}/pando --version")
  end
end
