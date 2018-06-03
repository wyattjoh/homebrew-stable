class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  url "https://github.com///releases/download/v1.0.2/cloudflare-ddns_v1.0.2_darwin_amd64.tar.gz"
  version "1.0.2"
  sha256 "67c2b250d461509b73c4da2957b601f8d24e913c7a6909ac8e750b12a265f5e8"

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
