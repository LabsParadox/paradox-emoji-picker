import SwiftUI

struct EmojiPickerView: View {
  // MARK: - Properties

  private let onEmojiSelected: (Emoji?) -> Void
  private let onDismiss: () -> Void
  private let emojis = EmojiRepository.shared.emojis

  // MARK: - Observables

  @Environment(\.dismiss) private var dismiss

  @FocusState private var isSearchFocused: Bool

  @State private var sectionTitle = ""
  @State private var searchText = ""
  @State private var filteredEmojis: [Emoji] = []

  // MARK: - Initializers

  init(
    onEmojiSelected: @escaping (Emoji?) -> Void,
    onDismiss: @escaping () -> Void
  ) {
    self.onEmojiSelected = onEmojiSelected
    self.onDismiss = onDismiss
  }

  // MARK: - Body

  var body: some View {
    VStack {
      searchBar
        .padding(.horizontal, .small)

      if filteredEmojis.isEmpty {
        HStack {
          Text("No Results")
            .foregroundStyle(.secondary)
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 32)
      } else {
        ScrollView(.horizontal, showsIndicators: false) {
          LazyHStack(spacing: 8) {
            ForEach(filteredEmojis) { emoji in
              Button {
                onEmojiSelected(emoji)
              } label: {
                Text(emoji.value ?? "")
                  .font(.system(size: 32))
                  .frame(width: 44, height: 44)
              } // Button
            } // ForEach
          } // LazyHStack
        } // ScrollView
        .frame(height: 32)
        .padding(.leading, .extraSmall)
      } // if/else (filteredEmojis.isEmpty)
    } // VStack
    .padding(.vertical, 8)
    .background(.ultraThinMaterial)
    .onAppear {
      filteredEmojis = emojis
      isSearchFocused = true
    }
    .onChange(of: searchText) {
      updateFilteredEmojis()
    }
    .onChange(of: isSearchFocused) {
      if !isSearchFocused {
        onDismiss()
      }
    }
  } // body

  private func updateFilteredEmojis() {
    let query = searchText.lowercased()
    if query.isEmpty {
      filteredEmojis = emojis
    } else {
      filteredEmojis = emojis.filter { emoji in
        emoji.value?.contains(query) == true ||
          emoji.description.lowercased().contains(query) ||
          emoji.aliases.contains(where: { $0.contains(query) }) ||
          emoji.tags.contains(where: { $0.contains(query) })
      } // filteredEmojis...
    } // if/else (query.isEmpty)
  } // updateFilteredEmojis()
} // EmojiPickerView (struct)

extension EmojiPickerView {
  private var searchBar: some View {
    HStack(alignment: .center) {
      HStack {
        Image(systemName: "magnifyingglass")
          .foregroundStyle(.secondary)

        TextField("Describe an Emoji", text: $searchText)
          .textInputAutocapitalization(.never)
          .disableAutocorrection(true)
          .keyboardType(.asciiCapable)
          .focused($isSearchFocused)

        if !searchText.isEmpty {
          Button {
            searchText = ""
          } label: {
            Image(systemName: "xmark.circle.fill")
              .foregroundStyle(.secondary)
          } // Button (x)
          .buttonStyle(.plain)
        } // if (!searchText.isEmpty)
      } // HStack
      .padding(.horizontal, .small)
      .frame(height: 36)
      .background(.background)
      .clipShape(Capsule())

      Button {
        isSearchFocused = false
        onDismiss()
      } label: {
        Image(systemName: "checkmark.circle.fill")
          .font(.system(size: 32))
          .symbolRenderingMode(.multicolor)
          .foregroundStyle(.blue)
      } // Button (check)
      .buttonStyle(.plain)
      .frame(width: 36, height: 36)
    } // HStack
  } // searchBar
} // EmojiPickerView (extension)
