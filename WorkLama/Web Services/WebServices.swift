// calling api
// checks internet availability

import Foundation
import UIKit
import SystemConfiguration

public class WebServices{
    
    
    // creates request from fetch data from server.
    class func requestHttp<T:Decodable>(urlString:String,method:HttpsMethod, param:Dictionary<String, Any>?, decode:@escaping(Decodable) -> T?, completion: @escaping (Result<T?,APIError>)->()){
    
        let url = urlString
        guard let request = HeaderRequest.requestWithHeaders(httpMethod: method, url: url, parameters: param) else{
            completion(Result.failure(APIError.failedRequest("HTTP request is failed")))
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                
            } else {
                guard let serverData = data,
                    error == nil else {
                        completion(Result.failure(APIError.failedRequest(error?.localizedDescription)))
                        return
                }
                
                do{
                    let decoder = JSONDecoder();
                    let object = try decoder.decode(T.self, from: serverData)
                    
                    completion(Result.success(object))
                } catch let parsingError {
                    
                    completion(Result.failure(APIError.failedRequest(parsingError.localizedDescription)))
                }
            }
        })
        dataTask.resume()
    }
    
    static func fetchJSONData<T:Decodable>(fileName:String,decode:@escaping(Decodable) -> T?,completion: @escaping (Result<T?,APIError>)->()) {
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: FileType.json.value) else {
            // return with failure in case invalid url
            completion(Result.failure(APIError.failedRequest("bad url")))
            return
        }
        
        do {
            // Get data from file
            let data = try Data(contentsOf: fileUrl)
            
            // Decode data to json model
            let dataRecieved = try JSONDecoder().decode(T.self, from: data)
            
            //return with success
            completion(Result.success(dataRecieved))
            
        } catch let error {
            
            //return with failure
            completion(Result.failure(APIError.failedRequest(error.localizedDescription)))
        }
    }
    
}




