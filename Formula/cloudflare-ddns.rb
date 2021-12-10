# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  version "1.0.28"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.28/cloudflare-ddns_v1.0.28_darwin_arm64.tar.gz"
      sha256 "9bf59bbf182c15eef93ba8fa384af15fefd8ccadc3d301caa21c75bbf4c364d9"

      def install
        bin.install "cloudflare-ddns"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.28/cloudflare-ddns_v1.0.28_darwin_amd64.tar.gz"
      sha256 "cae47aca8fc8dcc1026ae4f7ffeeb29c533783dd7de729b50068d7e02b183d58"

      def install
        bin.install "cloudflare-ddns"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.28/cloudflare-ddns_v1.0.28_linux_amd64.tar.gz"
      sha256 "05bade2266e9b2a2c1a6e5bcd50c226cd2279b465e1fa5f0e05f88401ab7a113"

      def install
        bin.install "cloudflare-ddns"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.0.28/cloudflare-ddns_v1.0.28_linux_arm64.tar.gz"
      sha256 "8a4a57c788c6f241cb2507e0a5e6f65c0c1b1d9f9c35781e324859386cb5ab86"

      def install
        bin.install "cloudflare-ddns"
      end
    end
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
