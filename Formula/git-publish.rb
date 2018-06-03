class GitPublish < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/git-publish"
  url "https://github.com/wyattjoh/git-publish/releases/download/v1.0.3/git-publish_v1.0.3_darwin_amd64.tar.gz"
  version "1.0.3"
  sha256 "ef3114e3e2ca12fe0693b79f05ac70966f5e6fa7ef7c9abfcfd76181f1689fb3"

  def install
    bin.install "git-publish"
  end

  test do
    system "#{bin}/git-publish -v"
  end
end
