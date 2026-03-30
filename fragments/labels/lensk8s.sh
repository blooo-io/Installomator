lensk8s)
    # Lens K8S IDE — official download hub: https://lenshq.io/download
    # Apple Silicon: api.k8slens.dev/binaries/latest-arm64.dmg → …/Lens-<version>-arm64.dmg (not latest.dmg, which is Intel x86_64).
    name="Lens"
    type="dmg"
    downloadURL="https://api.k8slens.dev/binaries/latest-arm64.dmg"
    # Redirect target includes -arm64 before .dmg; strip it so appNewVersion matches CFBundleShortVersionString.
    appNewVersion=$(curl -fsIL "$downloadURL" | grep -i ^location | tail -1 | sed -E 's/.*\/Lens-(.+)-arm64\.dmg.*/\1/' | tr -d '\r')
    expectedTeamID="JJ22T2W355"
    blockingProcesses=( Lens )
    ;;
