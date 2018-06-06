class Ims < Formula
  desc "image manipulation service, written in Go"
  homepage "https://github.com/wyattjoh/ims"
  url "https://github.com/wyattjoh/ims/releases/download/v1.2.0/ims_v1.2.0_darwin_amd64.tar.gz"
  version "1.2.0"
  sha256 "09cd31817b346cfb08f1af582c75479e45b22bb054af6dc9fcd542584a578418"

  def install
    bin.install "ims"
  end

  test do
    system "#{bin}/ims -v"
  end
end
