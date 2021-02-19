# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  version "1.4.5"
  bottle :unneeded

  if OS.mac? && Hardware::CPU.intel?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.5/ims_v1.4.5_darwin_amd64.tar.gz"
    sha256 "7b2225b706a34136d866886c66921364713a18f63e0831510ef5661291045096"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.5/ims_v1.4.5_linux_amd64.tar.gz"
    sha256 "4cc654e501ff55a885ee854481d32b2b05d22f86c66c0bcb845930968027df96"
  end
  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://github.com/wyattjoh/ims/releases/download/v1.4.5/ims_v1.4.5_linux_arm64.tar.gz"
    sha256 "a3cfe09dc90b3ae21f3b348987ba871f3d120c79dd21b43a90319a9d2f4fe152"
  end

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
