//
//  API.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 05.09.2022.
//

enum API {
    
    static var baseURL = "https://api.nytimes.com/svc/mostpopular/v2"
    
    case getEmailedNews(Int)
    case getSharedNews(Int)
    case getViewedNews(Int)
    
    var stringValue: String {
        switch self {
        case .getEmailedNews(let period): return "/emailed/\(period).json?"
        case .getSharedNews(let period): return "/shared/\(period).json?"
        case .getViewedNews(let period): return "/viewed/\(period).json?"
        }
    }
}
