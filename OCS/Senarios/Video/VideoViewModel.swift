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
    private let videoService = VideoService()
    var bag = Set<AnyCancellable>()
    
    init(subtitle: String, titleT : String, urlPrg : String) {
        self.subtitle.send(subtitle)
        self.titleT.send(titleT)
        self.urlPrg.send(urlPrg)
    }
    
    init() {}
    
    func getDetailsSerie() {
        if Reachability.isConnectedToNetwork(){
            isLoading.send(true)
            guard let url = encodeUrl(urlDetail: urlPrg.value)else {
                return
            }
            videoService.fetch(urlDetail: url).sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }, receiveValue: { response in
                self.isLoading.send(false)
                guard let content = response.content else {
                    return
                }
                if let season = content.season {
                    if let pitch = season[0].pitch {
                        self.pitch.send(pitch)
                    }
                }else{
                    guard let pitch = content.pitch else {
                        return
                    }
                    self.pitch.send(pitch)
                }
            }).store(in: &bag)
            
        } else {
            connexion.send(true)
        }
    }
    
    func encodeUrl(urlDetail : String) -> URL? {
        return URL(string: urlDetail)
        
    }
}
