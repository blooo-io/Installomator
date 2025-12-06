flameshot)
    # Flameshot - Powerful screenshot tool (signed macOS build from blooo-io fork)
    # https://github.com/blooo-io/flameshot
    name="flameshot"
    type="dmg"
    # Get latest version from GitHub API (tag format: vX.Y.Z-b-signed, version: X.Y.Z)
    appNewVersion=$(curl -fs "https://api.github.com/repos/blooo-io/flameshot/releases/latest" | grep -o '"tag_name": "[^"]*"' | head -1 | sed -E 's/.*"v([0-9.]+)-.*/\1/')
    # Handle architecture differences: arm64 for Apple Silicon, intel for x86_64
    if [[ $(arch) == "arm64" ]]; then
        printlog "Architecture: arm64 (Apple Silicon)"
        downloadURL="https://github.com/blooo-io/flameshot/releases/latest/download/Flameshot-${appNewVersion}-arm64.dmg"
    else
        printlog "Architecture: i386 (Intel)"
        downloadURL="https://github.com/blooo-io/flameshot/releases/latest/download/Flameshot-${appNewVersion}-intel.dmg"
    fi
    # Team ID verified from: codesign -dv "/Volumes/Flameshot 1/flameshot.app"
    expectedTeamID="L57HJ6AMTD"
    ;;

