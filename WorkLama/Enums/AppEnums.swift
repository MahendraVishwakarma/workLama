//
//  AppEnums.swift
//  WorkLama
//
//  Created by Mahendra Vishwakarma on 07/11/19.
//  Copyright © 2019 Mahendra Vishwakarma. All rights reserved.
//

import Foundation

// generics type
public enum Result<T, U> where U:Error{
    case success(T)
    case failure(U)
}

// custom error
public enum APIError:Error{
    
    case failedRequest(String?)
}

public enum FileType{
    case json
    var value:String{
        switch self{
        case .json: return "json"
        }
    }
}

// hTTPS methods type
public enum HttpsMethod{
    case Post
    case Get
    case Put
    case Delate
    
    var localization:String{
        switch self {
        case .Post: return "POST"
        case .Get: return "GET"
        case .Put: return "PUT"
        case .Delate: return "Delete"
            
        }
        
    }
}

