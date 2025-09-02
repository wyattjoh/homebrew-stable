class VercelScripts < Formula
  desc "Interactive CLI tool for managing Vercel and Next.js development workflows"
  homepage "https://github.com/wyattjoh/vercel-scripts"
  url "https://github.com/wyattjoh/vercel-scripts.git",
      tag:      "v0.2.4",
      revision: "68d35e0687811ad2c941824c72289ff6d0f7ec90"
  license "MIT"
  head "https://github.com/wyattjoh/vercel-scripts.git", branch: "main"

  depends_on "rust" => :build
  depends_on "jq"
  depends_on "git"

  def install
    # Compile the Deno application to a standalone binary
    system "cargo", "install", *std_cargo_args

    # Generate completions using Cliffy's built-in CompletionsCommand.
    generate_completions_from_executable(bin/"vss", "completions")
  end

  test do
    # Test that the binary runs and shows help
    assert_match "Vercel Scripts Selector", shell_output("#{bin}/vss --help 2>&1")
  end
end