//
//  GFError.swift
//  Github_Followers
//
//  Created by Kevin Vu on 4/20/21.
//

import Foundation

// these error message cases are based on URLSession task completion properties
// (data, response, error), checking for error, then response, then data,
// then attempting to decode the data. Also we have a case for invalid username
// since we are building our url via the username first.
enum GFError: String {
    /// Error for invalid usernames.
    case invalidUsername = "This username created an invalid request. Please try again"
    
    /// Error for typical internet connection issues which render the request incomplete.
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    
    /// Error for an invalid response from the server. i.e. HTTP response status code is not 200.
    case invalidResponse = "Invalid response from the server. Please try again."
    
    /// Error for invalid data following successful response.
    case invalidData = "The data received from the server was invalid. Please try again"
}
