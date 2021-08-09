# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  version "1.4.9"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/ims/releases/download/v1.4.9/ims_v1.4.9_darwin_amd64.tar.gz"
      sha256 "96fb1d6431e4a13b0afd23c65e209b7644fa4c1d45be331a60bbb266f384e92e"
    end
    if Hardware::CPU.arm?
      url "https://github.com/wyattjoh/ims/releases/download/v1.4.9/ims_v1.4.9_darwin_arm64.tar.gz"
      sha256 "246624cd1dcbdebda79424eae0d8e4f607ebdf28d463674a9929798df990137a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/ims/releases/download/v1.4.9/ims_v1.4.9_linux_amd64.tar.gz"
      sha256 "5089204a3b46a0653f83ddc802c3aebfafcb33541842dd2d9298dfe2121bfb18"
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/wyattjoh/ims/releases/download/v1.4.9/ims_v1.4.9_linux_arm64.tar.gz"
      sha256 "33fea9eb5283b7a26007405bb185ef2505aa64af4c0691d5b8c81f94f444e49d"
    end
  end

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
