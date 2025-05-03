// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "EmojiPicker",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "EmojiPicker",
      targets: ["EmojiPicker"]
    )
  ],
  targets: [
    .target(
      name: "EmojiPicker",
      resources: [
        .process("Resources/emojis.json")
      ]
    )
  ]
)
