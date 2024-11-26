import SwiftUI

struct EmojiPickerView: View {
  // MARK: - Properties

  private let onEmojiSelected: (Emoji?) -> Void
  private let categories = EmojiRepository.shared.categories
  private let emojis = EmojiRepository.shared.emojis

  // MARK: - Observables

  @Environment(\.dismiss) private var dismiss
  @State private var sectionTitle = ""

  // MARK: - Initializers

  init(
    onEmojiSelected: @escaping (Emoji?) -> Void
  ) {
    self.onEmojiSelected = onEmojiSelected
  }

  // MARK: - Body

  var body: some View {
    if #available(iOS 16.0, *) {
      NavigationStack {
        VStack(spacing: .small) {
          sectionTitleText
          emojiGrid()
          sectionSelectionView
        }
        .padding(.horizontal)
        .presentationDetents([.fraction(0.45)])
        .presentationDragIndicator(.visible)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button("Clear") {
              onEmojiSelected(nil)
              dismiss()
            }
          } // ToolbarItem
        } // .toolbar
      } // NavigationStack
    } // if #available
  } // body
} // EmojiPickerView (struct)

extension EmojiPickerView {
  private var sectionTitleText: some View {
    Text(sectionTitle.uppercased())
      .font(.EmojiPicker.caption)
      .foregroundStyle(.EmojiPicker.secondary)
      .padding(.bottom, .medium)
  }

  private var sectionSelectionView: some View {
    HStack(spacing: .zero) {
      ForEach(categories) { category in
        Spacer()
        sectionButton(category: category)
      }
      Spacer()
    }
  }

  private func sectionButton(category: EmojiCategory) -> some View {
    Button(
      action: {
        NotificationCenter.default.post(
          name: .categorySelected,
          object: nil,
          userInfo: ["name": category.title]
        )
      },
      label: {
        Image(category.iconName, bundle: .module)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: .medium, height: .medium)
          .foregroundColor(
            category.title == sectionTitle
              ? .EmojiPicker.primary
              : .EmojiPicker.secondary
          )
          .padding(.small)
          .background(
            category.title == sectionTitle
              ? .EmojiPicker.highlight
              : .EmojiPicker.background
          )
          .clipShape(Circle())
      }
    )
  }

  private func emojiGrid() -> some View {
    EmojiPickerGridView(
      with: emojis,
      width: UIScreen.main.bounds.width,
      onEmojiAppeared: { emoji in
        sectionTitle = emoji.category
      },
      onEmojiSelected: { emoji in
        onEmojiSelected(emoji)
        dismiss()
      }
    )
    .padding(.bottom, .medium)
  }
}
