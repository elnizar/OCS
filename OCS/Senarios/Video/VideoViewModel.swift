//
//  VideoViewModel.swift
//  OCS
//
//  Created by Nizar Elhraiech on 24/10/2021.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class VideoViewModel {
    
    // MARK: Variable
    var subtitle = CurrentValueSubject<String,Never>("")
    var titleT = CurrentValueSubject<String,Never>("")
    var urlPrg = CurrentValueSubject<String,Never>("")
    var pitch = CurrentValueSubject<String,Never>("")
    var connexion = CurrentValueSubject<Bool,Never>(false)
    var isLoading = PassthroughSubject<Bool,Never>()
    private let httpManager = HTTPManager()

    init(subtitle: String, titleT : String, urlPrg : String) {
        self.subtitle.send(subtitle)
        self.titleT.send(titleT)
        self.urlPrg.send(urlPrg)
    }
    
    init() {}
    
    func getDetailsSerie() {
        if Reachability.isConnectedToNetwork(){
            isLoading.send(true)
            getDetailsSerieResponseModel(urlPrg: urlPrg.value, completionHandler: {
                response,error  in
                guard let response = response else{
                    self.isLoading.send(false)
                    return
                }
                self.isLoading.send(false)
                self.pitch.send(response)
            })
            
        } else {
            connexion.send(true)
        }
    }
    
    func getDetailsSerieResponseModel(urlPrg : String , completionHandler: @escaping (String?,Bool?) -> Void)  {
        if let url = URL(string: urlPrg){
            httpManager.get(url: url, completionBlock: {
                response,error,urlResponse  in
                
                guard let res = response else{
                    completionHandler(nil, true)
                    return
                }
                DispatchQueue.main.async {
                    let decode = JSONDecoder()
                    
                    let data = try! decode.decode(Detail.self, from: res)
                    
                    if let _ = data.content.season {
                        if let pitch = data.content.season![0].pitch {
                            completionHandler(pitch, false)
                        }
                    }
                    else{
                        guard let pitch = data.content.pitch else {
                            return
                        }
                        completionHandler(pitch, false)
                    }
                }

            })

        }else{
            completionHandler(nil, true)
        }
    }
}
