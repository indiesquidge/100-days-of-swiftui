## BetterRest - Day 28

### Notes

Dates are hard, so Swift gives us a few ways to work with them.

`Date()` encapsulates the year, month, date, hour, minutes, seconds, timezone, etc.

 ```swift
let today = Date()
let tomorrow = Date().addingTimeInterval(60 * 60 * 24)
 ```

`DateComponents()` lets us read specific parts of a date rather than the whole thing.

 ```swift
let components = DateComponens()
components.hour = 8
components.minute = 0
let date = Calendar.current.date(from: components) ?? Date()
```

`Calendar.current.dateComponents` lets us get values from an existing Date instance

 ```swift
let today = Date()
let components = Calendar.current.dateComponents([.hour, .minute], from: today)
let hour = components.hour ?? 8
let minute = components.minute ?? 0
```

`DateFormatter()` lets us format dates and times into a string in different ways

 ```swift
let formatter = DateFormatter()
formatter.timeStyle = .short
let dateString = formatter.string(from: Date())
```
