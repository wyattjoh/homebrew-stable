# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  version "1.0.25"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.25/cloudflare-ddns_v1.0.25_darwin_amd64.tar.gz"
      sha256 "8a9e9f39bf650a6278e296bc8d5e6485e6464f2f5c5b83ee57e64c258ce20328"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.25/cloudflare-ddns_v1.0.25_linux_amd64.tar.gz"
      sha256 "0c9ebc6d04e3f416040d0b1b6b1cc5e71895cc9d20a0b6a041148b6f7dd85e2c"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.25/cloudflare-ddns_v1.0.25_linux_arm64.tar.gz"
      sha256 "c00c724364ff6a9559695c5a379b286336929a925e81b96a19746f834c8dba32"
    end
  end

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
