cask "boost" do
  version "1.0.0"
  sha256 "2282ebcdf836236353f1bafdd294638b83511acbbdbfffb5b3a8b2b6b0fdd336"

  url "https://github.com/Kernel-Hunter/boost/releases/download/v#{version}/Boost.zip",
      verified: "github.com/Kernel-Hunter/boost/"
  name "Boost"
  desc "Memory and disk utility for macOS"
  homepage "https://github.com/Kernel-Hunter/boost"

  depends_on macos: ">= :sonoma"

  app "Boost.app"

  uninstall quit: "boost.local.app"

  # Everything Boost writes. keep.txt is a list you built by hand, so `zap`
  # removes it and plain `uninstall` leaves it — reinstalling should not cost
  # you your pins.
  zap trash: [
    "~/Library/Application Support/Boost",
    "~/Library/Preferences/boost.local.app.plist",
  ]
end
