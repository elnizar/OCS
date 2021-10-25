//
//  HomeViewModel.swift
//  OCS
//
//  Created by Nizar Elhraiech on 24/10/2021.
//

import Foundation
import Combine

@available(iOS 13.0, *)
class HomeViewModel {
    
    // MARK: Variable
    var errorFromServer = CurrentValueSubject<Bool,Never>(false)
    var connexion = CurrentValueSubject<Bool,Never>(false)
    var programme = PassthroughSubject<Programme,Never>()
    var programmeTitle = CurrentValueSubject<String,Never>("")
    private let httpManager = HTTPManager()
    let programmeUrl = "https://api.ocs.fr/apps/v2/contents?search=title%3D"
    
    func getProgramme() {
        if Reachability.isConnectedToNetwork(){
            getProgrammeResponseModel(programmeTitle: programmeTitle.value, completionHandler: {
                response in
                self.programme.send(response)
            })
        } else {
            connexion.send(true)
        }
    }
    
    func getProgrammeResponseModel(programmeTitle : String ,completionHandler: @escaping (Programme) -> Void) {
        if let url = URL(string: programmeUrl + programmeTitle) {
            httpManager.get(url: url, completionBlock: {
                response,error,urlResponse  in
                
                guard let res = response else{
                    return
                }
                DispatchQueue.main.async {
                    let decode = JSONDecoder()
                        
                    let data = try! decode.decode(Programme.self, from: res)
                    completionHandler(data)
                }

            })
        }else{
            errorFromServer.send(true)
        }
    }
    
    func VideoVM(subtitle: String, titleT : String, urlPrg : String) -> VideoViewModel {
        return VideoViewModel(subtitle: subtitle, titleT: titleT, urlPrg: urlPrg)
    }
    
    func loadImage(imageUrl : String , completionHandler: @escaping (Data?) -> Void){
        
        guard let url = URL(string: imageUrl) else { return }
        
        httpManager.downloadImage(forURL: url, completion: {
            result in
                guard let data = try? result.get() else {
                    return
                }
            completionHandler(data)
        })
    }
}
