class VercelScripts < Formula
  desc "Interactive CLI tool for managing Vercel and Next.js development workflows"
  homepage "https://github.com/wyattjoh/vercel-scripts"
  url "https://github.com/wyattjoh/vercel-scripts.git",
      tag:      "v0.1.19",
      revision: "87509b66203c25c7b5c19298d33608db4809fbe8"
  license "MIT"
  head "https://github.com/wyattjoh/vercel-scripts.git", branch: "main"

  depends_on "deno" => :build
  depends_on "jq"
  depends_on "git"

  def install
    # Compile the Deno application to a standalone binary
    system "deno", "task", "build"
    
    # Install the compiled binary
    bin.install "vss"

    # Generate completions using Cliffy's built-in CompletionsCommand.
    generate_completions_from_executable(bin/"vss", "completions")
  end

  test do
    # Test that the binary runs and shows help
    assert_match "Vercel Scripts Selector", shell_output("#{bin}/vss --help 2>&1")
  end
end