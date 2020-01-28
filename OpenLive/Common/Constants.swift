//
//  Constants.swift
//  Saathi
//
//  Created by iGridiMac on 23/01/20.
//  Copyright © 2020 iGridiMac. All rights reserved.
//

import Foundation


struct Constans {
    
    struct StoryBoardIdentifiers
      {
          static let Main = "Main"
      }
    
    struct ServiceApi
       {
           static let SubDomain = "/plesk-site-preview/saathi.igridconsulting.com/saathi/"
           static let LoginAPI = "GetUserByName"
        
        static let MedSubDomain = "/plesk-site-preview/saathi.igridconsulting.com/saathi/"
        static let MedLoginAPI = "/med_api/index.php"
    }
    
    struct UserDefaultsKey
      {
          static let UserName = "userName"
          static let UserID = "userId"
          static let DomainUrl = "domainUrl"
    }
    
    
    struct ErrorMessage
    {
        static let Alert = "Alert"
    }
}
