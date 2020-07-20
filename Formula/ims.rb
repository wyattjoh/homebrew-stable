# This file was generated by GoReleaser. DO NOT EDIT.
class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  version "1.3.6"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/wyattjoh/ims/releases/download/v1.3.6/ims_v1.3.6_darwin_amd64.tar.gz"
    sha256 "66488f9a004fc9cf1bacf0f19eee1b5b7ef0da643207495352d0f2033bec5169"
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/wyattjoh/ims/releases/download/v1.3.6/ims_v1.3.6_linux_amd64.tar.gz"
      sha256 "bf8b48b9fcafa9469e12107d2bee7f5bfac50006af82df9d611221bf8a63fb5c"
    end
    if Hardware::CPU.arm?
      if Hardware::CPU.is_64_bit?
        url "https://github.com/wyattjoh/ims/releases/download/v1.3.6/ims_v1.3.6_linux_arm64.tar.gz"
        sha256 "d76fa87abc596f1fb3bb320a138886f6d32c6bd5166f195a5f3074cb0911fbfb"
      else
      end
    end
  end

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
