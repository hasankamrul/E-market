//
//  EndPoint.swift
//  E-Market Demo
//
//  Created by MAC on 1/10/22.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}


public enum AllApi {
    
    case storeInfo
    case products
    case order(order: Order)
}

extension AllApi : EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://virtserver.swaggerhub.com/m-tul/opn-mobile-challenge-api/1.0.0"
        case .qa: return "https://virtserver.swaggerhub.com/m-tul/opn-mobile-challenge-api/1.0.0"
        case .staging: return "https://virtserver.swaggerhub.com/m-tul/opn-mobile-challenge-api/1.0.0"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        
        case .storeInfo:
            return "/storeInfo"
        case .products:
            return "/products"
//        case .order(order: let order):
//            return "/order"
        case .order:
            return "/order"
        
        }
    }
    
    var httpMethod: HTTPMethod {
        
        switch self {
        
        case .storeInfo:
            return .get
        case .products:
            return .get
        case .order(_):
            return .post
        
        }
    }
    
    var task: HTTPTask {
        switch self {
        
        /////////
        case .storeInfo:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
            
        case .products:
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
            
        case .order(order: let order):
            
            let parameter = ["products": order.products,
                             "delivery_address": order.deliveryAddress] as [String : Any]
//            return .requestParameters(bodyParameters: order.toDictionary(),
//                                      bodyEncoding: .urlEncoding,
//                                      urlParameters: nil)
            return .requestParameters(bodyParameters: parameter, bodyEncoding: .urlEncoding, urlParameters: nil)
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
