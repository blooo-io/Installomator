ledgerwallet)
    # Ledger Live Desktop application (app bundle is named "Ledger Wallet.app")
    name="Ledger Wallet"
    type="dmg"
    # Get the latest version from GitHub API by filtering for desktop releases
    # The tag format is "@ledgerhq/live-desktop@X.Y.Z" and we extract the version number
    appNewVersion=$(curl -fs "https://api.github.com/repos/LedgerHQ/ledger-live/releases" | grep -o '"tag_name": "@ledgerhq/live-desktop@[^"]*"' | head -1 | sed -E 's/.*@([0-9.]+)"/\1/')
    # Construct download URL using the version number
    # Format: https://download.live.ledger.com/ledger-live-desktop-VERSION-mac.dmg
    downloadURL="https://download.live.ledger.com/ledger-live-desktop-${appNewVersion}-mac.dmg"
    # Team ID verified from code signature: codesign -dv "Ledger Wallet.app"
    expectedTeamID="X6LFS5BQKN"
    ;;
