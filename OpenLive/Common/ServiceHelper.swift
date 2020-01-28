//
//  ServiceHelper.swift
//  Saathi
//
//  Created by iGridiMac on 22/01/20.
//  Copyright © 2020 iGridiMac. All rights reserved.
//

import Foundation
import Alamofire

struct ServiceHelper
{
    static let shared = ServiceHelper()
    
//    func checkLogin(userName : String, password : String , Datetime : String, completionHandler : @escaping(Any? , Error?) -> Void)
//    {
//        let encryptObj = StringEncryption()
//        let key = encryptObj.sha256("password", length: 32)
//        let iv = encryptObj.generateRandomIV(16)!
//        
//        let encrptedUserName = encryptObj.encrypt(userName.data(using: String.Encoding.utf8), key: key, iv:iv)!
//        
//        let encryptedUserNameString = encrptedUserName.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
//        
//        let encrptedPassword = encryptObj.encrypt(password.data(using: String.Encoding.utf8), key: key, iv:iv)!
//        let encryptedPasswordString = encrptedPassword.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
//        
//        let postString = "UserName=\(encryptedUserNameString)&Password=\(encryptedPasswordString)&iv=\(iv)&Datetime=\(Datetime)"
//        
//        print("IV------->", postString)
//        
//        let replacedData = postString.replacingOccurrences(of: "+", with: "*")
//        let replace = replacedData.replacingOccurrences(of: "/", with: "@")
//
//        var request = self.getRequestWithUrl(urlString: self.getUrl(urlString: Constants.ServiceApi.Login), method: "POST")
//        request.httpBody = replace.data(using: String.Encoding.utf8)
//        print("Request \(request)")
//        
////        Alamofire.request( "http:''//win.igridconsulting.com/ServicesOperations/GetUserByName?UserName=apac&Password=trig@123&iv=1" , headers: nil)
////            .responseJSON { response in completionHandler(response.result.value , response.result.error)
////    }
//        
//        Alamofire.request(request).responseJSON { (response) in
//            completionHandler(response.result.value  , response.result.error)
//            
//            print("LoginResponse------->", response)
//
//        }
//        
//        
//    }
    
 
    func MedLoginKPIs( userName : String, password : String , completionHandler: @escaping (Any?, Error?) -> Void)
         {
             let postString =  "email=" + userName + "&password=" + password
          
             let request = self.getMedRequestWithUrl(urlString: Constans.ServiceApi.MedLoginAPI, postData: postString)
                  print("getMedLoginKPIs Request \(request)?\(postString)")
             Alamofire.request(request).responseJSON { (response) in
                 completionHandler(response.result.value  , response.result.error)
            
             }
         }

   
    
    private func getMedRequestWithUrl(urlString : String, postData : String) -> URLRequest
        {
            let url = URL(string: self.getMedUrl(urlString: urlString))!
            var request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 120.0)
            request.httpMethod = "POST" //set http method as POST
            request.httpBody = postData.data(using: String.Encoding.utf8)
            return request
            
        }
       
    
    private func getMedUrl(urlString : String)-> String
     {
         return Commonfunction.shared.getmedDomainUrl()  + urlString
     }
}
