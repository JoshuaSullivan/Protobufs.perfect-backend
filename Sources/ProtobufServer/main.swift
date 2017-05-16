//
//  main.swift
//  PerfectTemplate
//
//  Created by Kyle Jessup on 2015-11-05.
//	Copyright (C) 2015 PerfectlySoft, Inc.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the Perfect.org open source project
//
// Copyright (c) 2015 - 2016 PerfectlySoft Inc. and the Perfect project authors
// Licensed under Apache License v2.0
//
// See http://perfect.org/licensing.html for license information
//
//===----------------------------------------------------------------------===//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
server.serverName = "ProtoServer"
server.serverAddress = "localhost"
server.serverPort = 8080

let route = Route(method: .post, uri: "/proto") {
    request, response in
    Log.debug(message: "Got new request.")
    guard let bytes = request.postBodyBytes else {
        Log.error(message: "Request contained no data.")
        response.completed(status: .badRequest)
        return
    }
    guard let message = try? SimpleMessage(serializedData: Data(bytes)) else {
        Log.error(message: "Unable to deserialize SimpleMessage protobuf.")
        response.completed(status: .internalServerError)
        return
    }
    Log.debug(message: "Got message: \(message.content)")
    let reversed = String(message.content.characters.reversed())
    var responseMessage = SimpleMessage()
    responseMessage.content = reversed
    guard let responseData = try? responseMessage.serializedData() else {
        Log.error(message: "Unable to serialize new SimpleMessage protobuf.")
        response.completed(status: .internalServerError)
        return
    }
    response.bodyBytes = [UInt8](responseData)
    response.addHeader(HTTPResponseHeader.Name.contentType, value: "application/octet-stream")
    response.completed(status: .ok)
    Log.debug(message: "Successfully returned reversed message.")
}

server.addRoutes(Routes([route]))
try? server.start()
Log.info(message: "Server is now started at localhost:8080")
