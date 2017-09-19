class GitPublish < Formula
  desc "Small git tool to help out with frequent work with extra branches."
  homepage "https://github.com/wyattjoh/git-publish"
  url "https://github.com/wyattjoh/git-publish/archive/v1.0.1.tar.gz"
  sha256 "3e6d16226181cc511684c18e174559f96e855c65477d6b046c8385b40e0fd645"
  head "https://github.com/wyattjoh/git-publish.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/wyattjoh/git-publish"
    dir.install buildpath.children
    cd dir do
      system "go", "build", "-o", bin/"git-publish"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"git-publish", "--help"
  end
end