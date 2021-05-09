//
//  Constants.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/2/21.
//

import UIKit

// MARK: - SF Symbols
enum SFSymbols {
    static let location = "mappin.and.ellipse"
    static let repos = "folder"
    static let gists = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}


// MARK: - Screen size
enum ScreenSize {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let maxLength = max(ScreenSize.width, ScreenSize.height)
    static let minLength = min(ScreenSize.width, ScreenSize.height)
}


// MARK: - Device types
enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale
    
    /**
     Checks if the device height is 568.0 points. Includes iPhone SE 1st gen, 5, 5s, and 5c.
     */
    static let isiPhoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
    
    /**
     Checks if the device height is 667.0 points. Includes iPhone 6, 6s, 7, and 8 standard.
     */
    static let isiPhone8Standard = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    
    /**
     Checks if the device height is 667.0 points and if the `nativeScale > scale`.  Includes the iPhone 8 standard devices, which have `Display Zoom` enabled. Essentially turns screen size into iPhone SE 1st gen
     */
    static let isiPhone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    
    /**
     Checks if the device height is 736.0 points. Includes iPhone 6+, 6s+, 7+, and 8+.
     */
    static let isiPhone8PlusStandard = idiom == .phone && ScreenSize.maxLength == 736.0
    
    /**
     Checks if the device height is 736.0 points and if the `nativeScale < scale`. Includes the `iPhone8PlusStandard` devices. Essentially turns iPhone 8+ screen size into 8 standard.
     */
    static let isiPhone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    
    /**
     Checks if the device height is 812.0 points. Includes iPhone 11 Pro, X, and Xs.
     */
    static let isiPhoneX = idiom == .phone && ScreenSize.maxLength == 812.0
    
    /**
     Checks if the device height is 896.0 points. Includes iPhone 11, 11 Pro Max, Xr, and Xs Max.
     However, the iPhone 11 Pro Max and Xs Max have a `scale` of 3.
     */
    static let isiPhoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
    
    /**
     Checks if the device height is 844.0 points. Includes iPhone 12 and 12 Pro.
     */
    static let isiPhone12 = idiom == .phone && ScreenSize.maxLength == 844.0
    
    /**
     Checks if the device height is 926.0 points. Includes iPhone 12 Pro Max.
     */
    static let isiPhone12ProMax = idiom == .phone && ScreenSize.maxLength == 926.0
    
    /**
     Checks if the device height is 780.0 points. Includes iPhone 12 Mini.
     */
    static let isiPhone12Mini = idiom == .phone && ScreenSize.maxLength == 780.0
    
    
    /**
     Checks if the device height is greater than or equal to 1024.0. Should include most iPads.
     */
    static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0
    
    
    /**
     Returns a `bool` if the device aspect ratio is ~2.16.
     
     Includes devices in the following categories related to this enum:
     - `isiPhoneX`
     - `isiPhoneXsMaxAndXr`
     - `isiPhone12`
     - `isiPhone12ProMax`
     - `isiPhone12Mini`
     */
    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr || isiPhone12 || isiPhone12ProMax || isiPhone12Mini
    }
}
