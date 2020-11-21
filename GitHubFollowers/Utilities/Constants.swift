//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 10/5/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

enum SFSymbols {
    static let location                 = UIImage(systemName: "mappin.and.ellipse")
    static let repos                    = UIImage(systemName: "folder")
    static let gists                    = UIImage(systemName: "text.alignleft")
    static let followers                = UIImage(systemName: "heart")
    static let following                = UIImage(systemName: "person.2")
}

enum Images {
    static let emptyStateLogo           = UIImage(named: "empty-state-logo")
    static let placeholder              = UIImage(named: "avatar-placeholder")
    static let ghLogo                   = UIImage(named: "gh-logo")
}

enum ScreenSize
{
  static let SCREEN_WIDTH               = UIScreen.main.bounds.size.width
  static let SCREEN_HEIGHT              = UIScreen.main.bounds.size.height
  static let SCREEN_MAX_LENGTH          = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
  static let SCREEN_MIN_LENGTH          = min(ScreenSize.SCREEN_WIDTH,    ScreenSize.SCREEN_HEIGHT)
}

enum DeviceType
{
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    
    static let isiPhoneSE               = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.SCREEN_MAX_LENGTH   >= 1024.0
    
    static func isiPhoneXAspectRatio() -> Bool{
        return isiPhoneX || isiPhoneXsMaxAndXr
    }

}
