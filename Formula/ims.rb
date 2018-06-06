class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  url "https://github.com/wyattjoh/ims/releases/download/v1.3.0/ims_v1.3.0_darwin_amd64.tar.gz"
  version "1.3.0"
  sha256 "512b9c1b5cf91e392751c7c2241275b26b4cca3b2ad9d2d9a041a0957d9152fe"

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
