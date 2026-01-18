class NextDevUtils < Formula
  desc "A powerful CLI toolkit for Next.js development, providing utilities for packaging, deploying, and debugging Next.js applications."
  homepage "https://github.com/wyattjoh/next-dev-utils"
  url "https://github.com/wyattjoh/next-dev-utils.git",
      tag:      "v2.5.0",
      revision: "e17fa52e6f89831a5c118166275096a647b10cd4"
  license "MIT"
  head "https://github.com/wyattjoh/next-dev-utils.git", branch: "main"

  depends_on "deno" => :build

  def install
    # Compile the Deno application to a standalone binary
    system "deno", "task", "build" 
    
    # Install the compiled binary
    bin.install "nu"

    # Generate completions using Cliffy's built-in CompletionsCommand
    generate_completions_from_executable(bin/"nu", "completions")
  end

  test do
    # Test that the binary runs and shows help
    assert_match "Next.js development utilities", shell_output("#{bin}/nu --help 2>&1")
  end
end