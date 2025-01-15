#!/bin/bash

# Exit if any command fails
set -e

# Check if SwiftGen is installed
if ! command -v swiftgen &> /dev/null; then
    echo "SwiftGen is not installed. Installing via Homebrew..."
    brew install swiftgen
fi

# Create necessary directories if they don't exist
mkdir -p Sources/SwiftDevKit/Resources/Localization/en.lproj
mkdir -p Sources/SwiftDevKit/Resources/Colors.xcassets
mkdir -p Sources/SwiftDevKit/Resources/Templates
mkdir -p Sources/SwiftDevKit/Resources/Configurations
mkdir -p Sources/SwiftDevKit/Generated

# Run SwiftGen
echo "Running SwiftGen..."
swiftgen config run --config swiftgen.yml

echo "SwiftGen completed successfully!" 