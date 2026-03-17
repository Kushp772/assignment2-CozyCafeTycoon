/*:
 # CSCI 321/521 Assignment 2
 ## Part B: Swift Mastery Exercises
 
 Complete each exercise below. Your code should compile and run without errors.
 
 **Student Name: Kush Patel
 **Z-ID: z1986653
 
 ---
 */

import Foundation

/*:
 ## Exercise 1: Error Handling (15 points)
 
 ### 1a) ValidationError Enum
 Create an enum `ValidationError` that conforms to `Error` with the following cases:
 - `emptyField(fieldName: String)`
 - `invalidFormat(fieldName: String)`
 - `valueTooLong(fieldName: String, maxLength: Int)`
 */

// Your code for 1a here:
enum ValidationError: Error {
    case emptyField(fieldName: String)
    case invalidFormat(fieldName: String)
    case valueTooLong(fieldName: String, maxLength: Int)
}


/*:
 ### 1b) Validate Username Function
 Write a function `validateUsername(_ username: String?) throws -> String` that:
 - Throws `emptyField` if username is nil or empty
 - Throws `invalidFormat` if username contains non-alphanumeric characters
 - Throws `valueTooLong` if username length > 20
 - Returns the valid username if all checks pass
 
 **Hint:** You can use `CharacterSet.alphanumerics` to check for valid characters.
 */

// Your code for 1b here:
func validateUsername(_ username: String?) throws -> String {
    
    guard let username = username else {
        throw ValidationError.emptyField(fieldName: "Username")
    }
    
    if username.isEmpty {
        throw ValidationError.emptyField(fieldName: "Username")
    }
    
    if username.count > 20 {
        throw ValidationError.valueTooLong(fieldName: "Username", maxLength: 20)
    }
    
    let allowed = CharacterSet.alphanumerics
    if username.rangeOfCharacter(from: allowed.inverted) != nil {
        throw ValidationError.invalidFormat(fieldName: "Username")
    }
    
    return username
}


/*:
 ### 1c) Calling the Validation Function
 Demonstrate calling your validation function with:
 1. `do-catch` - handle different error cases
 2. `try?` - convert to optional
 3. `try!` - force try (use a value you KNOW is safe)
 */

// Your code for 1c here:

// Using do-catch:
do {
    let result = try validateUsername("Cafe123")
    print("Valid:", result)
} catch {
    print("Error:", error)
}

// try?
let optionalResult = try? validateUsername("Bad Name!")
print("try? result:", optionalResult as Any)

// Using try! (with a safe value):
let forcedResult = try! validateUsername("SafeUser")
print("try! result:", forcedResult)


/*:
 ### 1d) When to Use Each Approach
 Write a comment explaining when you would use each approach: `do-catch` vs `try?` vs `try!`
 */

/*
 Your explanation for 1d here:
 

 do-catch: when you want to handle errors properly
 

 try?: returns nil if error, simpler handling
 

 try!: crashes if error, use only when you are 100% sure it's safe
 
 */


/*:
 ---
 ## Exercise 2: Protocols (15 points)
 
 ### 2e) Displayable Protocol
 Create a protocol `Displayable` with the following requirements:
 - `var title: String { get }`
 - `var subtitle: String { get }`
 - `func formattedDescription() -> String`
 */

// Code from part A needed for this exercise
enum RecipeCategory: String {
    case drink = "Drink"
    case pastry = "Pastry"
    case dessert = "Dessert"
}

struct Recipe: Identifiable {
    let id = UUID()
    var name: String
    var category: RecipeCategory
    var price: Double
    var prepTime: Int
    var isUnlocked: Bool
    var imageName: String? = nil
    
    var formattedPrice: String {
        "$\(price)"
    }
    
    var isPremium: Bool {
        price >= 5.0
    }
}

// Your code for 2e here:

protocol Displayable {
    var title: String { get }
    var subtitle: String { get }
    func formattedDescription() -> String
}


/*:
 ### 2f) Conform Your Primary Model
 Copy your primary model from Part A (or create a simplified version) and make it conform to `Displayable`.
 
 
 **Note:** If you haven't completed Part A yet, create a simple model like `Book` or `Task` with a few properties.
 */

// Your code for 2f here:

struct CafeRecipe: Displayable {
    var name: String
    var category: String
    var price: Double
    var prepTime: Int
    
    var title: String {
        name
    }
    
    var subtitle: String {
        "\(category) - $\(price)"
    }
    
    func formattedDescription() -> String {
        "\(name) is a \(category.lowercased()) item that costs $\(price) and takes \(prepTime) seconds to make."
    }
}


/*:
 ### 2g) Second Conforming Type
 Create a second, unrelated struct (e.g., `Event`, `Product`, `Contact`) that also conforms to `Displayable`.
 */

// Your code for 2g here:

struct Event: Displayable {
    var name: String
    var location: String
    var date: String
    
    var title: String {
        name
    }
    
    var subtitle: String {
        "\(location) - \(date)"
    }
    
    func formattedDescription() -> String {
        "\(name) is happening at \(location) on \(date)."
    }
}


/*:
 ### 2h) Print Info Function
 Write a function `printInfo(for item: Displayable)` that prints the formatted description.
 */

// Your code for 2h here:

func printInfo(for item: Displayable) {
    print(item.formattedDescription())
}


/*:
 ### 2i) Demonstrate Protocol Usage
 Demonstrate calling `printInfo` with instances of both conforming types.
 */

// Your code for 2i here:

let recipeExample = CafeRecipe(
    name: "Latte",
    category: "Drink",
    price: 4.5,
    prepTime: 30
)

let eventExample = Event(
    name: "Coffee Festival",
    location: "Downtown Cafe Hall",
    date: "April 20"
)

printInfo(for: recipeExample)
printInfo(for: eventExample)


/*:
 ---
 ## Exercise 3: Generics (10 points)
 
 ### 3j) Generic findFirst Function
 Write a generic function:
 ```
 findFirst<T: Equatable>(in array: [T], where predicate: (T) -> Bool) -> T?
 ```
 that returns the first element matching the predicate.
 */

// Your code for 3j here:

func findFirst<T: Equatable>(in array: [T], where predicate: (T) -> Bool) -> T? {
    for item in array {
        if predicate(item) {
            return item
        }
    }
    return nil
}


/*:
 ### 3k) Demonstrate findFirst Usage
 Demonstrate using your `findFirst` function with:
 1. An array of `String`s
 2. An array of `Int`s
 */

// Your code for 3k here:

// With Strings:
let names = ["Latte", "Mocha", "Tea"]
print(findFirst(in: names) { $0.contains("T") } as Any)

// With Ints:
let numbers = [10, 20, 30, 40]
print(findFirst(in: numbers) { $0 > 25 } as Any)


/*:
 ### 3l) Generic Stack
 Write a generic struct `Stack<Element>` with the following methods:
 - `mutating func push(_ element: Element)`
 - `mutating func pop() -> Element?`
 - `func peek() -> Element?`
 - `var isEmpty: Bool { get }`
 
 Demonstrate its usage with at least one type.
 */

// Your code for 3l here:
struct Stack<Element> {
    
    private var items: [Element] = []
    
    // pushes an item onto the stack
    mutating func push(_ item: Element) {
        items.append(item)
    }
    // removes the top value
    mutating func pop() -> Element? {
        items.popLast()
    }
    
    // shows the top item
    func peek() -> Element? {
        items.last
    }
}

// Demonstrate usage:
var stack = Stack<String>()
stack.push("Latte")
stack.push("Mocha")

print(stack.peek() as Any)
stack.pop()
print(stack.peek() as Any)
stack.push("Cappacino")
print(stack.pop() as Any)
print(stack.peek() as Any)


/*:
 ---
 ## Exercise 4: Type Casting (10 points)
 
 ### 4m) Class Hierarchy
 Create a class hierarchy:
 - Base class `MediaItem` with a `title: String` property
 - Subclass `Movie` with a `director: String` property
 - Subclass `Song` with an `artist: String` property
 
 Include appropriate initializers for each class.
 */

// Your code for 4m here:

class MediaItem {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}

class Movie: MediaItem {
    var director: String
    
    init(title: String, director: String) {
        self.director = director
        super.init(title: title)
    }
}

class Song: MediaItem {
    var artist: String
    
    init(title: String, artist: String) {
        self.artist = artist
        super.init(title: title)
    }
}


/*:
 ### 4n) Mixed Array
 Create an array of `MediaItem` containing a mix of `Movie` and `Song` instances (at least 5 items total).
 */

// Your code for 4n here:
let library: [MediaItem] = [
    Movie(title: "Cars", director: "Pixar"),
    Song(title: "Wus Good / Curious", artist: "PARTYNEXTDOOR"),
    Movie(title: "The Dark Knight", director: "Christopher Nolan"),
    Song(title: "Throw Away", artist: "Future"),
    Movie(title: "Chainsaw Man - The Movie: Reze Arc", director: "Tatsuya Yoshihara"),
    Song(title: "Greece", artist: "Drake")
]


/*:
 ### 4o) Count with `is`
 Use a `for` loop with `is` to count how many movies and songs are in the array.
 Print the counts.
 */

// Your code for 4o here:

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Movies:", movieCount)
print("Songs:", songCount)


/*:
 ### 4p) Downcast with `as?`
 Use `as?` to safely downcast items and print movie-specific or song-specific information.
 */

// Your code for 4p here:
for item in library {
    if let movie = item as? Movie {
        print("Movie:", movie.title, "Directed by:", movie.director)
    }
    else if let song = item as? Song {
        print("Song:", song.title, "by", song.artist)
    }
}


/*:
 ---
 ## 🎉 Congratulations!
 
 You've completed the Swift Mastery exercises. Make sure to:
 1. Review your code for any errors
 2. Add comments where helpful
 3. Ensure everything compiles and runs
 
 OPTIONAL IF USING GIT:
 4. Commit your work to Git (minimum 3 commits)
 5. Create your Pull Request
 */
