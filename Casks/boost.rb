cask "boost" do
  version "1.0.0"
  sha256 "2282ebcdf836236353f1bafdd294638b83511acbbdbfffb5b3a8b2b6b0fdd336"

  url "https://github.com/Kernel-Hunter/boost/releases/download/v#{version}/Boost.zip"
  name "Boost"
  desc "Memory and disk utility for macOS"
  homepage "https://github.com/Kernel-Hunter/boost"

  depends_on macos: :sonoma

  app "Boost.app"

  # Boost is signed with a local certificate, not notarized — notarization needs
  # a paid Apple Developer account. Homebrew quarantines every cask it installs,
  # and macOS refuses to open a quarantined app it cannot verify, so without
  # this the install appears to succeed and the app will not start.
  #
  # Homebrew used to offer --no-quarantine for exactly this. It was removed in
  # Homebrew 7, leaving the cask itself as the only place to say it.
  #
  # This clears the quarantine flag on Boost and nothing else. If you would
  # rather not have an installer do that — a reasonable position — build from
  # source instead, which never involves Gatekeeper:
  #
  #     git clone https://github.com/Kernel-Hunter/boost.git
  #     cd boost && ./Scripts/build.sh
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Boost.app"],
                   sudo: false
  end

  uninstall quit: "boost.local.app"

  # Everything Boost writes. keep.txt is a list you built by hand, so `zap`
  # removes it and plain `uninstall` leaves it — reinstalling should not cost
  # you your pins.
  zap trash: [
    "~/Library/Application Support/Boost",
    "~/Library/Preferences/boost.local.app.plist",
  ]
end
