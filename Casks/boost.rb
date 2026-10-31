cask "boost" do
  version "1.4.1"
  sha256 "a4e0dfee9dee425d601447806f29001f0b9a31f9c2a7de8f65688b3fc320f59b"

  url "https://github.com/Kernel-Hunter/boost/releases/download/v#{version}/Boost.zip"
  name "Boost"
  desc "Memory and disk utility for macOS"
  homepage "https://github.com/Kernel-Hunter/boost"

  # From 1.5.0, Boost updates itself through Sparkle (Check for Updates in the
  # Boost menu). This tells `brew upgrade` to leave it alone unless asked with
  # --greedy, so Homebrew and the app do not both replace it.
  auto_updates true
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
  # Deliberately `postflight` and not `postflight_steps`, which Homebrew 7
  # prints a deprecation warning for: the replacement DSL does not expose
  # `appdir`, so the modern spelling fails outright with "undefined local
  # variable or method 'appdir'". A warning beats a cask that cannot be read.
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
    "~/Library/Caches/boost.local.app",
    "~/Library/HTTPStorages/boost.local.app",
    "~/Library/Preferences/boost.local.app.plist",
  ]
end
