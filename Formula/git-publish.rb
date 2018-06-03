class GitPublish < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/git-publish"
  url "https://github.com/wyattjoh/git-publish/releases/download/v1.0.2/git-publish_v1.0.2_darwin_amd64.tar.gz"
  version "1.0.2"
  sha256 "f22b08778c3327bb052278eda24eb228438da8d917f93e8903a92e2f8c3eb8c2"

  def install
    bin.install "git-publish"
  end

  test do
    system "#{bin}/git-publish -v"
  end
end
