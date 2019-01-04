//
//  ElementsAPIClient.swift
//  Elements
//
//  Created by TingxinLi on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

final class ElementsAPIClient {
    
    static func searchElements(keyword : String,completionHandler: @escaping (AppError?, [ElementsData]?) -> Void) {
        
        NetworkHelper.shared.performDataTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements", httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let elementsData = try JSONDecoder().decode([ElementsData].self, from: data)
                    completionHandler(nil, elementsData)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
    
    static func favoriteElements(data: Data, completionHandler: @escaping (AppError?, Bool) -> Void) {
        NetworkHelper.shared.performUploadTask(endpointURLString: "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites", httpMethod: "POST", httpBody: data) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, false)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), false)
                    return
            }
          
            if let _ = data {
                completionHandler(nil, true)
            }
        }
    }
    
  
    static func getFavorites(name: String, completionHandler: @escaping (AppError?, [Favorite]?) -> Void) {
        let getFavoritesEndpoint = "https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/favorites"
        NetworkHelper.shared.performDataTask(endpointURLString: getFavoritesEndpoint, httpMethod: "GET", httpBody: nil) { (appError, data, httpResponse) in
            if let appError = appError {
                completionHandler(appError, nil)
            }
            guard let response = httpResponse,
                (200...299).contains(response.statusCode) else {
                    let statusCode = httpResponse?.statusCode ?? -999
                    completionHandler(AppError.badStatusCode(String(statusCode)), nil)
                    return
            }
            if let data = data {
                do {
                    let favorites = try JSONDecoder().decode([Favorite].self, from: data)
                    completionHandler(nil, favorites)
                } catch {
                    completionHandler(AppError.decodingError(error), nil)
                }
            }
        }
    }
    
}
