test:
	set -o pipefail
	xcodebuild -project SwiftExplorer.xcodeproj \
           -scheme SwiftExplorer \
           -destination "platform=macOS" clean test | xcpretty
