# Pepe

it's just a simple yet customizable logger.

## Installation

Pepe is a swift package, so all you need to do is add the package via Xcode and that's it.

## How to use?

`Pepe` will provide you the logger that you need. For that, you need to be polite and use the method `loggerPlease()`.
```swift
let logger = Pepe.loggerPlease()
```
Once you have a logger, you can start logging the messages that you need.
```swift
logger.log("Hello world!")
// this would log: "🐸: Hello world!"
```

### Levels

There are four different types of levels.

- info
- debug
- warn
- error

You set the level when you are going to log a message, for example:

```swift
logger.log("some message", level: .debug)
```

*Note: by default, the level is **info***

## Advanced usage

### Modifiers
In case you need to modify the logging format, you have to use the `LogModifiers`. There's a property in the logger called `modifiers` that you can update. For example, let's suppose you need to show the log level and the time at which it was created, you would need to do the following.

```swift
logger.modifiers = [.level, .time]
logger.log("Modified log")
// this would log: "[INFO] 00:00:00.0000 modified log"
```

Notice that the log format will follow the order on which you added the modifiers.

### Writers

A writer basically means "how do you want to log something". At the moment, Pepe supports two types of writers:

- console: it will use the `print()` function.
- os: it will use the os logging system via the `os_log()` function.

```swift
// if you want to use the os logging system
logger.writer = .os(subsystem: "foo", category: "bar")
// notice that .console is the default value
```

### Execution type

Pepe supports logging in a syncronous scope and a non-sysncronous one.

#### Async

If you don't want to block your current Thread, this is what you have to use. For this kind of execution, you need to provide a DispatchQueue where the logging will run asyncronously.

```swift
logger.executionType = .async(DispatchQueue.global())
```

#### Sync

If you want to block the current Thread, you can use this type of execution. under the hood, it uses an `NSBlock`.

```swift
// This is the default value
logger.executionType = .sync
```
