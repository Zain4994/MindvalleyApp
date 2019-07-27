//
//  ServerError.swift
//  MindvalleyApp
//
//  Created by Zain Almasri on 7/26/19.
//  Copyright © 2019 Zain Almasri. All rights reserved.
//

import SwiftyJSON

/**
Server error represents custome errors types from back end
*/
struct ServerError {
	
	private var message: String? // server message
	private var status: Int? // server status
	private var code: Int! // server code
	
	/// Error type
	public var type: ErrorType {
		get {
			return ErrorType(rawValue: code) ?? .unknown
		}
	}
	
	/// Error message to show for the user
	public var errorMessage: String {
		get {
			if let m = ErrorType(rawValue: code)?.message, !m.isEmpty {
				return m
			}
			return message ?? ErrorType.unknown.message
		}
	}
	
	/// Server errors codes meaning according to backend
	enum ErrorType: Int {
		
		// in app errors
		case connection = -100
		case unknown = -101
		case noCached = -99
		
		/// Handle generic error messages
		var message: String {
			switch (self) {
			case .connection:
				return "Please check your internet conection"
			case .unknown:
				return "Unknown Error!"
			case .noCached:
				return "Error on cached data"
			}
		}
	}
	
	/// Connection error
	public static var connectionError: ServerError {
		get {
			var error = ServerError()
			error.code = ErrorType.connection.rawValue
			return error
		}
	}
	
	/// Unknow error
	public static var unknownError: ServerError {
		get {
			var error = ServerError()
			error.code = ErrorType.unknown.rawValue
			return error
		}
	}
	
	/// No cached
	public static var noCached: ServerError {
		get {
			var error = ServerError()
			error.code = ErrorType.noCached.rawValue
			return error
		}
	}
	
	// MARK: initializer
	public init() {
	}
	
	/**
	Initates the instance based on the JSON that was passed.
	- parameter json: JSON object from SwiftyJSON.
	- returns: An initalized instance of the class.
	*/
	public init?(json: JSON) {
		guard let errorCode = json["code"].int else {
			return nil
		}
		code = errorCode
		if let errorString = json["message"].string {
			message = errorString
		}
		if let statusCode = json["status"].int {
			status = statusCode
		}
	}
}
