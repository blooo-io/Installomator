windsurf)
    name="Windsurf"
    type="dmg"
    # Version and download URL from releases page: https://windsurf.com/editor/releases
    # Stable builds are served from windsurf-stable.codeiumdata.com (darwin-arm64-dmg or darwin-x64-dmg).
    if [[ $(arch) == "arm64" ]]; then
        archiveName="darwin-arm64-dmg"
    else
        archiveName="darwin-x64-dmg"
    fi
    downloadURL=$(curl -fsL "https://windsurf.com/editor/releases" | grep -oE "https://windsurf-stable\.codeiumdata\.com/${archiveName}/[^\"<>\\]*\.dmg" | head -1 | sed 's/\\$//')
    appNewVersion=$(curl -fsL "https://windsurf.com/editor/releases" | grep -oE "Windsurf-darwin-(arm64|x64)-[0-9]+\.[0-9]+\.[0-9]+\.dmg" | head -1 | sed -E 's/.*-([0-9]+\.[0-9]+\.[0-9]+)\.dmg/\1/')
    expectedTeamID="83Z2LHX6XW"
    blockingProcesses=( "Windsurf" )
    ;;
