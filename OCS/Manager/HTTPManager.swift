//
//  NetworkManager.swift
//  OCS
//
//  Created by Nizar Elhraiech on 24/10/2021.
//

import Foundation
import UIKit

class HTTPManager{
    
    enum DownloadError: Error {
        case emptyData
        case invalidImage
    }

    func downloadImage(forURL url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(DownloadError.emptyData))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
    
    public func get(url: URL, completionBlock: @escaping (Data?, Error?, URLResponse?) -> Void) {
        // make sure we pull new data each time
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionBlock(nil , error! , nil)
                return
            }

            guard let _ = data,
            let httpResponse = response as? HTTPURLResponse, 200 ..< 300 ~= httpResponse.statusCode else {
                    if let data = data {
                        completionBlock(data , nil, nil)
                    } else {
                        
                        completionBlock(data, nil, response)
                    }
                    return
            }
            // if passed guard
            if let data = data {
                completionBlock(data,nil,nil)
            }
        }
        task.resume()
    }
}
