//
//  String+Ext.swift
//  Github_Followers
//
//  Created by Kevin Vu on 5/4/21.
//

import Foundation

// don't need this if we use the .iso8601 dateDecodingStrategy for the JSONDecoder
// the date extension is good enough
extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        // use https://nsdateformatter.com/ as reference for various formats
        // github uses the below format
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        // most common US locale identifier
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
