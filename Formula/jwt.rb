# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Jwt < Formula
  desc "JWT Inspector"
  homepage "https://github.com/wyattjoh/jwt"
  version "0.1.0"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/wyattjoh/jwt/releases/download/v0.1.0/jwt_v0.1.0_darwin_amd64.tar.gz"
    sha256 "de69da930bba7269e6df5f122688571c0e01ffd0d995e5cdf806b913ad3ce43d"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/wyattjoh/jwt/releases/download/v0.1.0/jwt_v0.1.0_linux_amd64.tar.gz"
    sha256 "538aa84a2116ab73f60c9ba37b63f646447aad4d4b9f0b20ad6d34b6489dfbe3"
  end

  def install
    bin.install "jwt"
  end

  test do
    system "#{bin}/jwt -v"
  end
end
