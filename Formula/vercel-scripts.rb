class VercelScripts < Formula
  desc "Interactive CLI tool for managing Vercel and Next.js development workflows"
  homepage "https://github.com/wyattjoh/vercel-scripts"
  url "https://github.com/wyattjoh/vercel-scripts.git",
      tag:      "v0.1.13",
      revision: "40fbd4881ef6aadca7a4f93703ab0c3e11de4582"
  license "MIT"
  head "https://github.com/wyattjoh/vercel-scripts.git", branch: "main"

  depends_on "deno" => :build
  depends_on "jq"
  depends_on "git"

  def install
    # Compile the Deno application to a standalone binary
    system "deno", "compile", 
           "--allow-all", 
           "--include=src/scripts", 
           "--include=src/runtime",
           "--output=vss", 
           "src/main.ts"
    
    # Install the compiled binary
    bin.install "vss"
  end

  test do
    # Test that the binary runs and shows help
    assert_match "Vercel Scripts Selector", shell_output("#{bin}/vss --help 2>&1")
  end
end