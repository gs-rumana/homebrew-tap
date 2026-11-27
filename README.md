# gs-rumana/homebrew-tap

[![Tests](https://github.com/gs-rumana/homebrew-tap/actions/workflows/tests.yml/badge.svg)](https://github.com/gs-rumana/homebrew-tap/actions/workflows/tests.yml)

[Homebrew](https://brew.sh) casks for apps by gs-rumana.

## track.it

A local-first activity and task tracker for macOS. It lives in the menu bar and records which apps, windows and websites you use, and when you're idle, away or in a meeting. A small floating widget lets you say what you're working on, and a dashboard in your browser shows where the time went. Nothing leaves your Mac.

```bash
brew install --cask gs-rumana/tap/track-it
```

It needs macOS 13 or later; meeting detection needs macOS 14. `brew upgrade` picks up new versions. The disk images are also on the [releases page](https://github.com/gs-rumana/homebrew-tap/releases), `arm64` for Apple silicon and `x64` for Intel.

On first launch, click the menu-bar icon → **Open dashboard** and follow **Setup**:

| Permission | Used for | Without it |
| --- | --- | --- |
| Accessibility | Window titles | App names only |
| Automation, per browser | The current tab's URL and title in Chrome, Brave and Helium, and whether the window is private | Browser time without titles or URLs |

Other browsers, including Safari, Firefox, Arc and Edge, record only the time you spend in them, because track.it can't check whether their windows are private.

### It isn't notarized

track.it is signed ad hoc, not with an Apple Developer ID, so macOS won't open it while it carries the quarantine flag downloads get. The cask removes that flag after installing it.

macOS also ties the permissions to the app's signature, which changes with every version. After `brew upgrade`, reset them and grant them again from **Setup**:

```bash
tccutil reset Accessibility com.gursahb.trackit
tccutil reset AppleEvents com.gursahb.trackit
```

### Uninstall

`brew uninstall --cask track-it` removes the app and its login item and keeps your data. Add `--zap` to delete the data too: the database, logs and caches in `~/Library`.

## How the casks are updated

Each app's release workflow publishes its disk images as a release here, tagged like `track-it-v0.1.0`, and commits the cask that installs them, so please don't edit the casks by hand. [Tests](.github/workflows/tests.yml) check every change with `brew style` and `brew audit`, then install each cask on a clean Mac, launch the app, and uninstall it.

Found a problem with an app or a cask? [Open an issue](https://github.com/gs-rumana/homebrew-tap/issues).

## License

[MIT](LICENSE)
