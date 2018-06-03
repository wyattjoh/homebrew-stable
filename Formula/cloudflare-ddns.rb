class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  url "https://github.com///releases/download/v1.0.2/cloudflare-ddns_v1.0.2_darwin_amd64.tar.gz"
  version "1.0.2"
  sha256 "90479447fdb435b586a56b9497b7f8222e2bd758e829a8f074bf7e1a55a99600"

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
