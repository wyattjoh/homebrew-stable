class GitPublish < Formula
  desc "git branch publisher"
  homepage "https://github.com/wyattjoh/git-publish"
  url "https://github.com/wyattjoh/git-publish/releases/download/v1.0.5/git-publish_v1.0.5_darwin_amd64.tar.gz"
  version "1.0.5"
  sha256 "9c07b8e95b27d09be4a93bc78ed8ee42286effdf23e7f1e78da63df1aa7521e9"

  def install
    bin.install "git-publish"
  end

  test do
    system "#{bin}/git-publish -v"
  end
end
