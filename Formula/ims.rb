# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  version "1.4.2"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.2/ims_v1.4.2_darwin_amd64.tar.gz"
    sha256 "ee8c1844edba1fa75a8693aec472bdb60939366e146c7835e0889e7ca7690e78"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.2/ims_v1.4.2_linux_amd64.tar.gz"
    sha256 "837943b5da9ce79069e1d98363a72f9c911bc076f0a5e8e6699b1be34e559903"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.2/ims_v1.4.2_linux_arm64.tar.gz"
    sha256 "3b2e2adcabf0e5282a63333dbb47762025e65a1fa1535864fd81e7131c29b29d"
  end

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
