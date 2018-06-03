class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  url "https://github.com/wyattjoh/ims/releases/download/v1.0.0/ims_v1.0.0_darwin_amd64.tar.gz"
  version "1.0.0"
  sha256 "71cf38c47a64803922ba2b7775e4c53a9eae26ee786a2786a2d75375405f1284"

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
