class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.4/cloudflare-ddns_v1.0.4_darwin_amd64.tar.gz"
  version "1.0.4"
  sha256 "ad4d9202c6692882d862bfc70a3f737fd12e264eec902787dd3159944ba9056d"

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
