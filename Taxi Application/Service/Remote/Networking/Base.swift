//
//  Base.swift
//  Taxi Application
//
//  Created by ahmed mostafa on 13/02/2022.
//

import Alamofire
import CoreMedia

class BaseAPI<T: TargetType> {

    let sessionManager = EndPoint.fetchWeather.sessionManager

    func fetchWeather(target: T, completion: @escaping(Result<WeatherModelResponse?, Error>) -> Void) {
        let method = HTTPMethod(rawValue: target.method.rawValue)
        sessionManager.request(target.base + target.path, method: method, encoding: JSONEncoding.default, headers: target.headers)
            .response { response in
                let statusCode = response.response?.statusCode
                switch response.result {
                case.success:
                    guard let data = response.value else {return}
                    if statusCode == 200 {
                        self.decoded(WeatherModelResponse.self, with: data!) { responseOBj, err in
                            completion(.success(responseOBj))
                            if err != nil {
                                completion(.failure(err!))
                            }
                        }
                    } else if statusCode == 404 {
                        self.decoded(WeatherErrorModel.self, with: data!) { responseOBj, err in
                            let errorMessage = responseOBj?.message ?? ""
                            var tempModel: WeatherModelResponse!
                            tempModel = WeatherModelResponse(cod: errorMessage, message: nil, cnt: nil, list: nil)
                            completion(.success(tempModel))
                            if err != nil {
                                completion(.failure(err!))
                            }
                        }
                    }

                case .failure(let err):
                    debugPrint(err)
                    completion(.failure(err))
                }
            }
    }
    
    func decoded<T: Decodable>(_ objectType: T.Type,
                               with data: Data,
                               completion: @escaping  (T?, Error?) -> Void)  {
        
        do {
            let responseOBj = try JSONDecoder().decode(T.self, from: data)
            completion(responseOBj, nil)
        } catch {
            completion(nil, error)
        }
    }
}
