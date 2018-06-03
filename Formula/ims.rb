class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  url "https://github.com/wyattjoh/ims/releases/download/v1.1.0/ims_v1.1.0_darwin_amd64.tar.gz"
  version "1.1.0"
  sha256 "8b7fb63681f64f0b6c31ddfbae7b5e8dec4eaee58083e22b0c60727a17d6513e"

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
