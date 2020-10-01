//
//  GFError.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/29/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import Foundation

enum GFError: String, Error{
    case invalidUsername    = "This username created an invalid request. please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data recieved from server was invalid. Please try again."
}
