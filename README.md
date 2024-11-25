# 🤠 Paradox Emoji Picker
### ➡️ Forked From Mihai Petrenco's ([@mpetrenco](https://github.com/mpetrenco)) Emoji Picker [Repo](https://github.com/mpetrenco/EmojiPicker)
---------

<p align="center">
  <img src="https://github.com/user-attachments/assets/39149c11-7990-406f-9667-b0db2e2ca27a" 
       alt="Example of the Paradox Emoji Picker being used in Radar's iOS app."
       style="max-width: 200px; width: 40%; height: auto;">
</p>

<p align="center">
"i love emojis" -martino
</p>

## How to use:

__STEP 1:__  
Import the package:

```swift
import EmojiPicker
```

__STEP 2:__  
Add the `.emojiPicker(isDisplayed:onEmojiSelected:)` modifier to your view:

```swift
struct ContentView: View {
  @State var emojiValue = ""
  @State var isDisplayed = false
    
  var body: some View {
    VStack {
      Text(emojiValue)
      Button("Select Emoji") {
        isDisplayed.toggle()
      }
    }
    .emojiPicker(isDisplayed: $isDisplayed) { emoji in
      emojiValue = emoji?.value
    } // .emojiPicker
  } // body
} // ContentView (struct)
```

__STEP 3:__  
Bing, Bang, Boom, you're done! 💥
