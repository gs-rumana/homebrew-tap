cask "track-it" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0"
  sha256 arm:   "da269f50cf5e0876ebd510e850cb299d2c056fd8502d7000e222c831b5203587",
         intel: "7a5b1820809ee46c2abe01573817d7bd5a8966c57d87cf9a980fe8002ca75a5b"

  url "https://github.com/gs-rumana/homebrew-tap/releases/download/track-it-v#{version}/track.it-#{version}-#{arch}.dmg"
  name "track.it"
  desc "Local-first activity and task tracker"
  homepage "https://github.com/gs-rumana/homebrew-tap"

  livecheck do
    url :url
    regex(/^track-it-v?(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :ventura

  app "track.it.app"

  # Not notarized: Gatekeeper would refuse to open it while it's quarantined.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/track.it.app"]
  end

  uninstall launchctl: "track.it",
            quit:      "com.gursahb.trackit"

  zap trash: [
    "~/Library/Application Support/com.gursahb.trackit",
    "~/Library/Caches/com.gursahb.trackit",
    "~/Library/Logs/com.gursahb.trackit",
    "~/Library/WebKit/com.gursahb.trackit",
  ]

  caveats <<~EOS
    track.it isn't notarized, so this cask removes the quarantine flag
    that would stop macOS from opening it.

    macOS ties the Accessibility and Automation permissions to the app's
    signature, which changes with every version. After upgrading, run
      tccutil reset Accessibility com.gursahb.trackit
      tccutil reset AppleEvents com.gursahb.trackit
    and grant them again from Setup in the dashboard.
  EOS
end
