# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Rep < Formula
  desc "Javascript reproduction manager, written in Go"
  homepage "https://github.com/wyattjoh/rep"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/rep/releases/download/v0.1.0/rep_v0.1.0_darwin_arm64.tar.gz"
      sha256 "0472396588132216102606cff32461157206014b4bac6d679e1376bd8947aae4"

      def install
        bin.install "rep"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/rep/releases/download/v0.1.0/rep_v0.1.0_darwin_amd64.tar.gz"
      sha256 "a43e9eaf4660217091b18293f4c26affb7e27f4e62ddd765f380dd7a0a7fb207"

      def install
        bin.install "rep"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/rep/releases/download/v0.1.0/rep_v0.1.0_linux_amd64.tar.gz"
      sha256 "ab471ea262577cfbcaf125def680ddb04de8f05be93ec6a0479a880093267a5f"

      def install
        bin.install "rep"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/rep/releases/download/v0.1.0/rep_v0.1.0_linux_arm64.tar.gz"
      sha256 "020d5aa83abd9faa40c7f430f2658bf39eeb1cd3d7b859732ef18ac0909dfc45"

      def install
        bin.install "rep"
      end
    end
  end

  test do
    system "#{bin}/rep -v"
  end
end