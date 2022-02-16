//
//  EndPoint.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import Alamofire

var cityName: String!

enum EndPoint {
    case drawPolyline
    case fetchWeather
}

extension EndPoint: TargetType {

    var base: String {
        switch self {
        case .drawPolyline:
            return APIConstants.googleMapApiBaseURL
        default:
            return APIConstants.BaseURL
        }
    }
    var path: String {
        switch self {
        case .fetchWeather:
            return "q=\(cityName ?? "")&appid=\(APIConstants.AppId)"
        case .drawPolyline:
            return "origin=\(sourceLocaltion.latitude),\(sourceLocaltion.longitude)&destination=\(destinationLocation.latitude),\(destinationLocation.longitude)&mode=driving&key=\(APIConstants.googleApiKey)"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .fetchWeather:
            return .get
        case .drawPolyline:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .fetchWeather:
            return .requestPlain
        case .drawPolyline:
            return .requestPlain
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            let header: HTTPHeaders = ["Content-Type": "application/json; charset=utf-8"]
            return header
        }
    }
    var sessionManager: Session  {
        switch self {
        default:
            let configuration = URLSessionConfiguration.af.default
            configuration.requestCachePolicy = .returnCacheDataElseLoad
            let responseCacher = ResponseCacher(behavior: .modify { _, response in
                return CachedURLResponse(
                    response: response.response,
                    data: response.data,
                    storagePolicy: .allowed)
            })
            return Session(
                configuration: configuration,
                cachedResponseHandler: responseCacher)
        }
    }
}
