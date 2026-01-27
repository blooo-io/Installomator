ledgerwallet)
    # Ledger Live Desktop application (app bundle is named "Ledger Wallet.app")
    name="Ledger Wallet"
    type="dmg"
    # Get desktop releases from GitHub API
    # The desktop app DMG is often released a few days after the GitHub release tag,
    # so if the latest release is less than 7 days old, use the previous one instead
    releasesJSON=$(curl -fs "https://api.github.com/repos/LedgerHQ/ledger-live/releases")
    # Filter for desktop releases only (tag format: @ledgerhq/live-desktop@X.Y.Z)
    # Get the first two desktop releases: latest and previous
    latestTag=$(echo "$releasesJSON" | grep -o '"tag_name": "@ledgerhq/live-desktop@[^"]*"' | head -1 | sed -E 's/.*@([0-9.]+)"/\1/')
    previousTag=$(echo "$releasesJSON" | grep -o '"tag_name": "@ledgerhq/live-desktop@[^"]*"' | head -2 | tail -1 | sed -E 's/.*@([0-9.]+)"/\1/')
    # Get published_at date of the latest desktop release to check if it's recent
    latestPublishedAt=$(echo "$releasesJSON" | grep -B5 "@ledgerhq/live-desktop@${latestTag}" | grep '"published_at"' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')
    # Calculate age of the release in seconds
    currentTimestamp=$(date +%s)
    releaseTimestamp=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$latestPublishedAt" +%s 2>/dev/null || echo "0")
    releaseAgeSeconds=$((currentTimestamp - releaseTimestamp))
    oneWeekSeconds=$((7 * 24 * 60 * 60))
    # Use previous release if latest is less than 7 days old (DMG may not be available yet)
    if [[ $releaseAgeSeconds -lt $oneWeekSeconds && -n "$previousTag" ]]; then
        appNewVersion="$previousTag"
    else
        appNewVersion="$latestTag"
    fi
    # Construct download URL using the version number
    # Format: https://download.live.ledger.com/ledger-live-desktop-VERSION-mac.dmg
    downloadURL="https://download.live.ledger.com/ledger-live-desktop-${appNewVersion}-mac.dmg"
    # Team ID verified from code signature: codesign -dv "Ledger Wallet.app"
    expectedTeamID="X6LFS5BQKN"
    ;;
