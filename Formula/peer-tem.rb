class PeerTem < Formula
  desc "Peerigon Peer TEM [Travel Expense Manager]"
  homepage "https://github.com/peerigon/peer-tem"
  url "https://github.com/peerigon/homebrew-tap/releases/download/v1.0.0/peer-tem-macos-arm64.zip"
  sha256 "d090e1230b858d24f37c4f47516f4a576c2d5d0fd4c2e7e917c62aaa7420fc24"
  version "1.2.1"

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
