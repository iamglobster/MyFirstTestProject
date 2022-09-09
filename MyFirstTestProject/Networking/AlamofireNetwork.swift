//
//  AlamofireNetwork.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

import Alamofire

protocol AlamofireNetworkProtocol {
    func getNews<T: Decodable>(with stringURL: String, completion: @escaping ValueClosure<T>)
}

class AlamofireNetwork: AlamofireNetworkProtocol {

    func getNews<T: Decodable>(with stringURL: String, completion: @escaping ValueClosure<T>) {

        let urlParameters = ["api-key": "KAsh4iTgyKVsARTpPEpQ6h2tUlwLp9xY"]

        guard let url = URL(string: API.baseURL + stringURL) else { return }
        
        AF.request(url, parameters: urlParameters).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                self.printResponse(data: data)
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let news: T = try decoder.decode(T.self, from: data)
                    completion(news)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func printResponse(data: Data) {
        print(
        """
        DATA: -----------------------------------
        \(String(data: data, encoding: .utf8) ?? "")
        END DATA: -------------------------------
        """)
    }
}
