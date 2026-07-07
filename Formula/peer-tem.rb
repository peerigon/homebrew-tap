class PeerTem < Formula
  desc "Peerigon Peer TEM [Travel Expense Manager]"
  homepage "https://github.com/peerigon/peer-tem"
  url "https://github.com/peerigon/homebrew-tap/releases/download/peer-tem-v1.3.0/peer-tem-macos-arm64.zip"
  sha256 "f6ff36cb655f4633367b258b4b70a0b661d9d798271940a9cf33f9937270208d"
  version "1.3.0"

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
