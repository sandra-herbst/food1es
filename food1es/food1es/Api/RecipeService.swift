//
//  RecipeService.swift
//  food1es
//
//  Created by Sandra Herbst on 22.05.22.
//

import Foundation
import SwiftUI

protocol RecipeService {
    func fetchRecipeSearch(searchInput: String) async throws -> RecipeResult
    func fetchRecipeInformation(id: Int) async throws -> RecipeData
}

final class RecipeServiceImpl: RecipeService {
    
    var apiKey: String {
	// Spoonacular api key
	return ""
    }
    
    let urlSession = URLSession.shared
    
    var apiKeyQueryItem: URLQueryItem {
        URLQueryItem(name: "apiKey", value: apiKey)
    }
    
    func fetchRecipeSearch(searchInput: String) async throws -> RecipeResult {
        let url = ApiConstants.baseUrl + ApiConstants.recipeEndpoint + ApiConstants.searchEndpoint
        var urlComps = URLComponents(string: url)!
        urlComps.queryItems = [
            apiKeyQueryItem,
            URLQueryItem(name: "instructionsRequired", value: "true"),
            URLQueryItem(name: "fillIngredients", value: "true"),
            URLQueryItem(name: "addRecipeInformation", value: "true"),
            URLQueryItem(name: "query", value: searchInput)
        ]
        print("Fetching from url: \(urlComps.url!)")
        
        let (data, _) = try await urlSession.data(from: urlComps.url!)
        return try JSONDecoder().decode(RecipeResult.self, from: data)
    }
    
    func fetchRecipeInformation(id: Int) async throws -> RecipeData {
        let url = ApiConstants.baseUrl + ApiConstants.recipeEndpoint + "/\(id)" + ApiConstants.detailEndpoint
        var urlComps = URLComponents(string: url)!
        urlComps.queryItems = [
            apiKeyQueryItem,
        ]
        print("Fetching from url: \(urlComps.url!)")
        
        let (data, _) = try await urlSession.data(from: urlComps.url!)
        return try JSONDecoder().decode(RecipeData.self, from: data)
    }
}
