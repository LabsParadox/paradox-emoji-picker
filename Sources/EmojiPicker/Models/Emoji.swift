import Foundation

/// The representation of an emoji.
public struct Emoji: Hashable, Identifiable {
  /// The unique identifier used to conform to `Identifiable`.
  public let id = UUID()
    
  /// The String value of the emoji.
  public let value: String?
    
  /// The category of the emoji.
  public let category: String
    
  /// A list of alias terms associated with the emoji.
  public let aliases: [String]
    
  /// A list of tags associated with the emoji.
  public let tags: [String]
  
  /// A detailed descrition of the emoji.
  public let description: String
}

extension Emoji: Decodable {
  enum CodingKeys: String, CodingKey {
    case value = "emoji"
    case category
    case aliases
    case tags
    case description
  }
}
