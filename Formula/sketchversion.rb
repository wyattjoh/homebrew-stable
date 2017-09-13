class Sketchversion < Formula
  desc "Utility to download the most recent Sketch version based on your valid license."
  homepage "https://github.com/wyattjoh/sketchversion"
  url "https://github.com/wyattjoh/sketchversion/archive/v1.0.0.tar.gz"
  sha256 "43503d7bc62f3603b36289003b2a249367e147026eb3814bebba02bfa55bc894"
  head "https://github.com/wyattjoh/sketchversion.git"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    dir = buildpath/"src/github.com/wyattjoh/sketchversion"
    dir.install buildpath.children
    cd dir do
      system "go", "build", "-o", bin/"sketchversion"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"sketchversion", "--help"
  end
end