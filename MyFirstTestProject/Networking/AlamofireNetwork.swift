//
//  AlamofireNetwork.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

import Alamofire

protocol AlamofireNetworkProtocol {
    func getNews(with stringURL: String, completion: @escaping (News) -> Void)
}

class AlamofireNetwork: AlamofireNetworkProtocol {
    func getNews(with stringURL: String, completion: @escaping (News) -> Void) {

        let urlParameters = ["api-key": "KAsh4iTgyKVsARTpPEpQ6h2tUlwLp9xY"]

        guard let url = URL(string: API.baseURL + stringURL) else { return }
        
        AF.request(url, parameters: urlParameters).validate().responseDecodable(of: News.self) { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let news: News = try decoder.decode(News.self, from: data)
                    completion(news)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
