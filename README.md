# Kernel-Hunter's Homebrew tap

```bash
brew install --cask kernel-hunter/boost/boost
```

## Boost

A memory and disk utility for macOS that tells you the truth —
[source](https://github.com/Kernel-Hunter/boost).

Boost is signed with a local certificate rather than notarized, because
notarization needs a paid Apple Developer account. If macOS refuses to open it,
either clear the quarantine flag:

```bash
xattr -dr com.apple.quarantine /Applications/Boost.app
```

or install with `brew install --cask --no-quarantine kernel-hunter/boost/boost`,
or build it from source, which avoids the question entirely.
