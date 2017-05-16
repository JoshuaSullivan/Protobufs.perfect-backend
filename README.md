# Protocol Buffers – Perfect Web Server
This is one of two backends I created for experimenting with protocol buffers. The Perfect server uses slightly less memory, as it has fewer options installed by default. Setup is pretty simple using the [Perfect Assistant](https://perfect.org/en/assistant/), you just need to add the Protocol Buffers dependency to the Package.swift file.

See also: [Protocol Buffers – Vapor Web Server](https://github.com/JoshuaSullivan/Protobufs.vapor-backend)

## Installation Instructions
Already have Swift? Jump to **Install Server**.

### Install Swift

1. Open a terminal.
2. Install `swiftenv` using homebrew: `brew install swiftenv`.
    * Don't have homebrew? [Installation instructions here.](https://brew.sh)
3. Install Swift using swiftenv: `swiftenv install 3.1.1`

### Install Server

1. Clone this repository.
2. Open terminal in the directory you just created.
3. Compile the server: `swift build`

## Running the Server

1. In the same directory you just built from: `.build/debug/ProtobufServer`
2. You should see a message stating that the server has started at `localhost:8080`
3. Press Control-C to quit the server.
