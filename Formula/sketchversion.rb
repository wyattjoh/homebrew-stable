class Sketchversion < Formula
  desc "Utility to download the most recent Sketch version based on your valid license."
  homepage "https://github.com/wyattjoh/sketchversion"
  url "https://github.com/wyattjoh/sketchversion/releases/download/v1.0.1/sketchversion_v1.0.1_darwin_amd64.tar.gz"
  version "1.0.1"
  sha256 "948fb53b3042a53c7fcbf46101b420679ebf9c26cba2a504e543f549ca3c4e5b"

  def install
    bin.install "sketchversion"
  end

  test do
    system "#{bin}/sketchversion -v"
  end
end
