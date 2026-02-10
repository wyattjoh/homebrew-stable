class Resticprofile < Formula
  desc "Configuration profiles for restic backup"
  homepage "https://github.com/wyattjoh/resticprofile"
  url "https://github.com/wyattjoh/resticprofile.git",
      tag:      "v0.32.0-fork.1",
      revision: "819f606c6c4ef24d82c6814d23ed896abacc37c5"
  license "GPL-3.0-only"
  head "https://github.com/wyattjoh/resticprofile.git", branch: "master"

  depends_on "go" => :build

  depends_on "restic" => :optional

  def install
    ldflags = %W[
      -s -w
      -X main.version=#{version}
      -X main.commit=#{Utils.git_head}
      -X main.date=#{time.iso8601}
      -X main.builtBy=homebrew
    ]
    system "go", "build", *std_go_args(ldflags:), "-tags", "no_self_update"
  end

  test do
    assert_match "resticprofile", shell_output("#{bin}/resticprofile version 2>&1")
  end
end
