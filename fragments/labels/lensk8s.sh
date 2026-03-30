lensk8s)
    # Lens K8S IDE — official download hub: https://lenshq.io/download
    # macOS DMG is served via the same API pattern as the Linux AppImage in Lens docs (api.k8slens.dev/binaries/…).
    name="Lens"
    type="dmg"
    downloadURL="https://api.k8slens.dev/binaries/latest.dmg"
    # Follow redirect chain to CDN filename: …/Lens-<version>.dmg
    appNewVersion=$(curl -fsIL "$downloadURL" | grep -i ^location | tail -1 | sed -E 's/.*Lens-([^/]+)\.dmg.*/\1/' | tr -d '\r')
    expectedTeamID="JJ22T2W355"
    blockingProcesses=( Lens )
    ;;
