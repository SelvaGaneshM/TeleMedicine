//
//  Commonfunction.swift
//  OpenLive
//
//  Created by Rajaguru New Apple CEO on 06/01/20.
//  Copyright © 2020 Agora. All rights reserved.
//


import Foundation
import UIKit

struct Constants {
    
      struct CollectionViewCellIdentifier
      {
          static let Home = "homeCell"
        
      }
}


struct Commonfunction
{
    static let shared = Commonfunction()
    // MARK: - UIView custom functions
    
    /**
     Set border color and border width for any UIView class
     
     - Parameter view : UIView - UIView for which border color and border width to be set.
     - Parameter borderColor : UIColor - Color of border
     - Parameter borderWidth : CGFloat - Border width (EX : 1.0 , 2.0)
     */
    
    
    func getmedDomainUrl() -> String
       {
           if let domainUrl = UserDefaults.standard.object(forKey: Constans.UserDefaultsKey.DomainUrl) as? String
           {
               return domainUrl.replacingOccurrences(of: " ", with: "")
           }
       
           return "http://infocomtechnology.com"
       }
    
    func setBorderColorForView(_ view : UIView , borderColor : UIColor , borderWidth : CGFloat)
    {
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = true
    }
    
    /**
     Set cornerRadius for any UIView class
     
     - Parameter view : UIView - UIView for which cornerRadius to be set.
     - Parameter cornerRadius : CGFloat - cornerRadius (EX : 1.0 , 2.0)
     */
    
    func setCornerRadiusForView(_ view : UIView , cornerRadius : CGFloat)
    {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
    }
    
    /**
     Set Shadow effect for any UIView class
     
     - Parameter view : UIView - UIView for which cornerRadius to be set.
     - Parameter cornerRadius : CGFloat - cornerRadius (EX : 1.0 , 2.0)
     */
    
    func setShadowForView(_ view : UIView , cornerRadius : CGFloat , shadowOpacity : Float)
    {
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 2
        view.layer.shadowOpacity = shadowOpacity
    }
    
    // MARK: - Color functions
    
    /**
     Get the color for given hexa Int
     
     - Parameter netHex : Int - Hexa decimal value (Ex: 0xFFFFFF)
     - Returns UIColor
     
     */
    
    func getUIColorForHexaCode(_ netHex:Int) -> UIColor
    {
        return UIColor(red: CGFloat((netHex >> 16) & 0xff) / 255.0, green: CGFloat((netHex >> 8) & 0xff) / 255.0, blue: CGFloat(netHex & 0xff) / 255.0, alpha: 1.0)
    }
//    func linearGradientColor(from colors: [UIColor], locations: [CGFloat], size: CGSize) -> UIColor {
//        let image = UIGraphicsImageRenderer(bounds: CGRect(x: 0, y: 0, width: size.width, height: size.height)).image { context in
//            let cgColors = colors.map { $0.cgColor } as CFArray
//            let colorSpace = CGColorSpaceCreateDeviceRGB()
//            let gradient = CGGradient(
//                colorsSpace: colorSpace,
//                colors: cgColors,
//                locations: locations
//                )!
//            context.cgContext.drawLinearGradient(
//                gradient,
//                start: CGPoint(x: 0, y: 0),
//                end: CGPoint(x: size.width, y:0),
//                options:[]
//            )
//        }
//        return UIColor(patternImage: image)
//    }
    /**
     Get the color for given RGB value
     
     - Parameter red : CGFloat - Value for red code
     - Parameter green : CGFloat - Value for green code
     - Parameter blue : CGFloat - Value for blue code
     - Returns UIColor
     */
    
    func getUIColorForRGB(_ red : CGFloat , green : CGFloat , blue : CGFloat) -> UIColor
    {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    // MARK: - General function
    
    /**
     Get the instance of the appDelegate for application
     
     - Returns AppDelegate instance of the application
     */
    
    func getAppDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    /**
     Get the main screen bounds of the window
     
     - Returns : CGRect
     */
    
    func getMainScreenFrame() -> CGRect
    {
        return UIScreen.main.bounds
    }
    
    /**
     Set Status bar backGround color
     
     - Parameter color: UIColor - Status bar color
     */
    
    func setStatusBarBackgroundColor(_ color: UIColor) {
        
        guard  let statusBar = (UIApplication.shared.value(forKey: "statusBar") as? UIView) else {
            return
        }
        statusBar.backgroundColor = color
    }
    
    /**
     Get the Average color from the given image
     
     - Parameter image : UIImage - Image for which average color has to be find.
     - Returns UIColor - Average color from image if no color is found white color will be returned
     */
    
    func getAverageColorFromImage(_ image : UIImage) -> UIColor
    {
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()
        
        let info = CGImageAlphaInfo.premultipliedLast.rawValue
        if let context: CGContext = CGContext(data: rgba, width: 1, height: 1, bitsPerComponent: 8, bytesPerRow: 4, space: colorSpace, bitmapInfo: info)
        {
            context.draw(image.cgImage!, in: CGRect(x: 0, y: 0, width: 1, height: 1))
            if rgba[3] > 0
            {
                let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
                let multiplier: CGFloat = alpha / 255.0
                return UIColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
            }
            else
            {
                return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
            }
        }
        
        return UIColor.white
    }
    
    func createImageFromView(_ view : UIView) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
    
    func saveDetailsToUserDefault(detailDict : [String : Any])
    {
        UserDefaults.standard.setValuesForKeys(detailDict)
        UserDefaults.standard.synchronize()
    }
    
    func clearDetailsfromUserDefault(key : String)  {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    func getStringForKeyFromUserDefaults(key : String) -> String
    {
        if let value = UserDefaults.standard.string(forKey: key)
        {
            return value
        }
        return ""
    }
    
    func getBoolValueForKey(key : String) -> Bool
    {
        return UserDefaults.standard.bool(forKey: key)
    }
    
    func trimString(text : String?) -> String
    {
        if text != nil
        {
            return text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        return ""
        
    }
    
    func convertStringCoordinateToDoubleLatitude(coordinate : String)-> Double
    {
        var degree = Double()
        var minutes = Double()
        var direction = Double()
        
        let array = coordinate.components(separatedBy: " ")
        
        for coordinateComponenet in array
        {
            if coordinateComponenet.characters.count > 1
            {
                let lastChar = coordinateComponenet.characters.last!
                if lastChar == "°"
                {
                    degree = Double(String(coordinateComponenet.characters.dropLast()))!
                }
                else if lastChar == "'"
                {
                    minutes = Double(String(coordinateComponenet.characters.dropLast()))!
                }
                else
                {
                    if (lastChar == "N") || (lastChar == "E")
                    {
                        direction = 1.0
                    }
                    if (lastChar == "W") || (lastChar == "S")
                    {
                        direction = -1.0
                    }
                }
            }
        }
        let result = degree + minutes/60.0 * direction
        return result
    }

    func getViewControllerWithIdentifier(identifier : String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func checkInternetConnection() -> Bool
    {
        return false
    }
   
    func convertArrayToString(list : [String], seperator : String) -> String
    {
        var convertedString : String = ""
        for text in list
        {
            convertedString += convertedString != "" ? seperator : ""
            convertedString += text
        }
        return convertedString
    }
    
    
    
    
    func getDateComponents(date : Date) -> DateComponents
    {
        let calender = Calendar.init(identifier: Calendar.Identifier.gregorian)
        return calender.dateComponents([.year,.month,.day,.weekOfMonth,.weekOfYear,.hour,.minute,.weekday,.weekdayOrdinal,.quarter], from: date)
    }
    
    func convertDateStringToDate(dateString : String, dateFormat : String) -> Date
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        //print("CalendarDateString----->",dateString)
        
        
        return dateformatter.date(from: dateString)!
    }
    
    func convertDateToDateString(date : Date, dateFormat : String) -> String
    {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat
        dateformatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateformatter.string(from: date)
    }
    
    func getCurrentDateToString(date : Date, dateFormat : String) -> String
    {
    // create dateFormatter with UTC time format
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = dateFormat
    let date1 = dateFormatter1.string(from: date)
    
    // change to a readable time format and change to local time zone
    dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter1.timeZone = NSTimeZone.local
    let timeStamp = dateFormatter1.date(from: date1)
        
        return dateFormatter1.string(from: timeStamp!)
        
    }
    
    func getDateAddingInterval(interval : Int, component : Calendar.Component, date : Date) -> Date
    {
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        return calendar.date(byAdding: component, value: interval, to: date)!
    }
    
    func getCurrentDate() -> Date
    {
        return self.convertDateStringToDate(dateString: self.convertDateToDateString(date: Date(), dateFormat: "dd/MM/yyyy"), dateFormat: "dd/MM/yyyy")
    }
    
    func differenceInDate(fromDate: Date, toDate: Date)-> Int {
        return Calendar.init(identifier: Calendar.Identifier.gregorian).dateComponents([.day], from: fromDate, to: toDate).day ?? 0
    }
    
    
    func getTimeZoneFormatName(timeZoneName : String) -> String
    {
        let timeZone = TimeZone.init(identifier: timeZoneName)!
        
        let hours = timeZone.secondsFromGMT() / 3600
        var minutes = (timeZone.secondsFromGMT() / 60) % 60
        
        var timeDifference : String = ""
        if hours >= 0
        {
            timeDifference = "+"
        }
        
        if minutes < 0
        {
            minutes = minutes * -1
        }
        
        return String(format: "UTC %@ %02d:%02d (%@)", timeDifference,hours,minutes,timeZoneName)
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(hex: hex, a: 1.0)
    }
    
    convenience init(hex: Int, a: CGFloat) {
        self.init(r: (hex >> 16) & 0xff, g: (hex >> 8) & 0xff, b: hex & 0xff, a: a)
    }
    
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r: r, g: g, b: b, a: 1.0)
    }
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: a)
    }
    
    convenience init?(hexString: String, a : CGFloat = 1.0) {
        guard let hex = hexString.hex else {
            return nil
        }
        self.init(hex: hex, a: a)
    }
}

extension String
{
    var hex: Int? {
        return Int(self, radix: 16)
    }
}

extension NSAttributedString {
    convenience init(htmlString html: String, font: UIFont? = nil, useDocumentFontSize: Bool = true) throws {
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        let data = html.data(using: .utf8, allowLossyConversion: true)
        guard (data != nil), let fontFamily = font?.familyName, let attr = try? NSMutableAttributedString(data: data!, options: options, documentAttributes: nil) else {
            try self.init(data: data ?? Data(html.utf8), options: options, documentAttributes: nil)
            return
        }
        
        let fontSize: CGFloat? = useDocumentFontSize ? nil : font!.pointSize
        let range = NSRange(location: 0, length: attr.length)
        attr.enumerateAttribute(.font, in: range, options: .longestEffectiveRangeNotRequired) { attrib, range, _ in
            if let htmlFont = attrib as? UIFont {
                let traits = htmlFont.fontDescriptor.symbolicTraits
                var descrip = htmlFont.fontDescriptor.withFamily(fontFamily)
                
//                if (traits.rawValue & UIFontDescriptorSymbolicTraits.traitBold.rawValue) != 0 {
//                    descrip = descrip.withSymbolicTraits(.traitBold)!
//                }
//
//                if (traits.rawValue & UIFontDescriptorSymbolicTraits.traitItalic.rawValue) != 0 {
//                    descrip = descrip.withSymbolicTraits(.traitItalic)!
//                }
//
                attr.addAttribute(.font, value: UIFont(descriptor: descrip, size: fontSize ?? htmlFont.pointSize), range: range)
            }
        }
        self.init(attributedString: attr)
    }
}


extension Date {
    var startOfMonth: Date {
        
        
        let components = Calendar.init(identifier: Calendar.Identifier.gregorian).dateComponents([.year, .month], from: self)
        return Calendar.init(identifier: Calendar.Identifier.gregorian).date(from: components)!
    }
    
    var startOfWeek: Date {
        let date = Calendar.init(identifier: Calendar.Identifier.gregorian).date(from: Calendar.init(identifier: Calendar.Identifier.gregorian).dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    var endOfMonth : Date {
        return Calendar.init(identifier: Calendar.Identifier.gregorian).date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth)!
    }
}
