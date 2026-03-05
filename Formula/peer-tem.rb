class PeerTem < Formula
  desc "Peerigon Peer TEM [Travel Expense Manager]"
  homepage "https://github.com/peerigon/peer-tem"
  url "https://github.com/peerigon/peer-tem/releases/download/v1.2.0/peer-tem-macos-arm64.zip"
  sha256 "cbd8a1ddbbf3a20fb56eec16caa441700f3c4d2f53826f3eb4acc4c24a94345a"
  version "1.2.0"

  def install
    bin.install "peer-tem-macos-arm64" => "peer-tem"
  end

  def caveats
    <<~EOS
      peer-tem was installed successfully.

      Before using it, run the setup once:

        peer-tem

      This will configure your environment.
    EOS
  end

  test do
    output = shell_output("#{bin}/peer-tem help")
    assert_match "Available commands", output
  end
end
