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
    private let homeService = HomeService()
    var bag = Set<AnyCancellable>()
    
    func getProgramme() {
        if Reachability.isConnectedToNetwork(){
            guard let url = encodeUrl(title: programmeTitle.value)else {
                return
            }
            homeService.getProgrmmes(urlDetail: url).sink(receiveCompletion: {
                completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }, receiveValue: {
                response in
                self.programme.send(response)
                
            }).store(in: &bag)
        } else {
            connexion.send(true)
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
    
    func encodeUrl(title : String) -> URL? {
        guard let urlEncoded = title.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else {
            return nil
        }
        let fullUrl = Constants.programmeUrl + urlEncoded
        return URL(string: fullUrl)
        
    }
}
