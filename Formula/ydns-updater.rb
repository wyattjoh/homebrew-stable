# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class YdnsUpdater < Formula
  desc "YDNS DNS Updater"
  homepage "https://github.com/wyattjoh/ydns-updater"
  version "3.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/ydns-updater/releases/download/v3.0.4/ydns-updater_v3.0.4_darwin_arm64.tar.gz"
      sha256 "1a7f5d513997dd621cb3d3eeb0b8cd557c010e863a53daa6ff2fe355476366c5"

      def install
        bin.install "ydns-updater"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/ydns-updater/releases/download/v3.0.4/ydns-updater_v3.0.4_darwin_amd64.tar.gz"
      sha256 "68df8b38bc86addf5a1b6d0f904d46e0848b75de1c84cf9489695ddb973e1231"

      def install
        bin.install "ydns-updater"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/ydns-updater/releases/download/v3.0.4/ydns-updater_v3.0.4_linux_arm64.tar.gz"
      sha256 "502ae960001ba05e7c5fea9074e4302713da4805745ffd030ccb73ff1c5b218c"

      def install
        bin.install "ydns-updater"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/ydns-updater/releases/download/v3.0.4/ydns-updater_v3.0.4_linux_amd64.tar.gz"
      sha256 "d2e236e0935976b071f7a83092574a8a3eb52c0ed792703b8e3f0f35da046676"

      def install
        bin.install "ydns-updater"
      end
    end
  end

  test do
    system "#{bin}/ydns-updater -v"
  end
end
