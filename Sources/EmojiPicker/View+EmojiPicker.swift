import SwiftUI

public extension View {
  /// Displays an emoji picker sheet.
  ///
  /// - Parameters:
  ///   - isDisplayed: specifies if the picker should be displayed;
  ///   - onEmojiSelected: a callback with the selected `Emoji` value;
  ///
  /// - Returns: a `View` which contains the emoji picker sheet.
  func emojiPicker(
    isDisplayed: Binding<Bool>,
    onEmojiSelected: @escaping (Emoji?) -> Void
  ) -> some View {
    self.modifier(
      EmojiPickerModifier(
        isDisplayed: isDisplayed,
        onEmojiSelected: onEmojiSelected
      )
    )
  }
}
