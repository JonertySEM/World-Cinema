//
//  YearEnums.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 16.04.2023.
//

import Foundation
import UIKit

enum Year {
    case babyRating
    case childrenRating
    case teenageRating
    case almostAdultRating
    case adultRating
    
    static func getStatusRating(str: String) -> Self?  {
        switch str {
        case "0+":
            return .babyRating
        case "6+":
            return .childrenRating
        case "12+":
            return .teenageRating
        case "16+":
            return .almostAdultRating
        case "18+":
            return .adultRating
        default:
            return nil
        }
    }
    
    
    func getColorRating() -> UIColor{
        switch self {
        case .babyRating:
            return .white
        case .childrenRating:
            return GetHexColorHelper().hexStringToUIColor(hex: "#FAD5C9")
        case .teenageRating:
            return GetHexColorHelper().hexStringToUIColor(hex: "#F4A992")
        case .almostAdultRating:
            return GetHexColorHelper().hexStringToUIColor(hex: "#F26E45")
        case .adultRating:
            return GetHexColorHelper().hexStringToUIColor(hex: "#EF3A01")
        }
    }
    
}
