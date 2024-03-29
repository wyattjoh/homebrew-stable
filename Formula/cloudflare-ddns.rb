# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class CloudflareDdns < Formula
  desc "Cloudflare Dynamic DNS Updater"
  homepage "https://github.com/wyattjoh/cloudflare-ddns"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.1.0/cloudflare-ddns_v1.1.0_darwin_amd64.tar.gz"
      sha256 "1f88cf5bb438bd1bb6e7de8c1afa14257a1146a1dd4e354f83b5162681ce03a6"

      def install
        bin.install "cloudflare-ddns"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.1.0/cloudflare-ddns_v1.1.0_darwin_arm64.tar.gz"
      sha256 "dc2dda5cd189119608dae555a916ea5b5482f8ad6f76fc2dc831284bf110f574"

      def install
        bin.install "cloudflare-ddns"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.1.0/cloudflare-ddns_v1.1.0_linux_amd64.tar.gz"
      sha256 "010b4977527406c8050d54fd893f48b191ee7d5dec13ca4e2c835f48b2668f04"

      def install
        bin.install "cloudflare-ddns"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/cloudflare-ddns/releases/download/v1.1.0/cloudflare-ddns_v1.1.0_linux_arm64.tar.gz"
      sha256 "7c35a4b49563e7a9994e07bdf4afaae582acb46d3b3e8397619a749b2706af79"

      def install
        bin.install "cloudflare-ddns"
      end
    end
  end

  test do
    system "#{bin}/cloudflare-ddns -v"
  end
end
