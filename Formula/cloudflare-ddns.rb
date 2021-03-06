# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  version "1.0.24"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.24/cloudflare-ddns_v1.0.24_darwin_amd64.tar.gz"
      sha256 "3df7bf9855dadf8e521c5f1a3ccbbea35535f87d168753f98c5dc2edd9c3fde4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.24/cloudflare-ddns_v1.0.24_linux_amd64.tar.gz"
      sha256 "bbd075f1ef99f79c45208ef0a6a7cd9037c675151a6461c81c678ac221cb6f6e"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.24/cloudflare-ddns_v1.0.24_linux_arm64.tar.gz"
      sha256 "eaf61e643768148bd5a7c85567eff276a73e04cad29cd0a019e24e24038aeebf"
    end
  end

  def install
    bin.install "cloudflare-ddns"
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
