import SwiftUI

struct EmojiPickerModifier: ViewModifier {
  // MARK: - Properties
  
  @Binding private var isDisplayed: Bool
  private let onEmojiSelected: (Emoji?) -> Void
  
  // MARK: - Initializers
  
  init(
    isDisplayed: Binding<Bool>,
    onEmojiSelected: @escaping (Emoji?) -> Void
  ) {
    _isDisplayed = isDisplayed
    self.onEmojiSelected = onEmojiSelected
  }
  
  // MARK: - Body
  
  public func body(content: Content) -> some View {
    ZStack(alignment: .bottom) {
      content
      if isDisplayed {
        EmojiPickerView(
          onEmojiSelected: { emoji in
            onEmojiSelected(emoji)
          },
          onDismiss: { isDisplayed = false }
        )
        .transition(.move(edge: .bottom).combined(with: .opacity))
        .animation(.easeInOut(duration: 0.25), value: isDisplayed)
      } // if (isDisplayed)
    } // ZStack
  } // body
} // EmojiPickerModifier (struct)
