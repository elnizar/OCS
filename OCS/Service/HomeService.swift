//
//  Service.swift
//  OCS
//
//  Created by Nizar Elhraiech on 26/10/2021.
//

import Foundation
import Combine

class HomeService {
    
    
    @available(iOS 13.0, *)
    func getProgrmmes(urlDetail: URL) -> AnyPublisher<Programme, Error> {
        let request = URLRequest(url: urlDetail)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    throw NetworkError.invalidResponse
                }
                return data
            }
            .mapError { $0 as Error }
            .decode(type: Programme.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
