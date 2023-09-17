//
//  APIService.swift
//  Swiftui_movie
//
//  Created by Liem Vo on 12/1/19.
//  Copyright © 2021. All rights reserved.
//

import Alamofire
import Foundation

fileprivate let api_key = "170e8430f540b8f79110ca126792bca5"
fileprivate let api_url_base = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key="
let BASE_IMAGE_URL = "https://image.tmdb.org/t/p/original/"

class APIService : ServiceProtocol {
	func fetchPopularMovies(completion: @escaping ([Movie]?) -> Void) {
		loadDataByAlamofire(completion)
	}
	
	private func loadDataNormal(_ completion: @escaping ([Movie]?) -> Void) {
		guard let url = URL(string: "\(api_url_base)\(api_key)") else { return }
		URLSession.shared.dataTask(with: url){ (data, _, _) in
			guard let data = data else {
				completion(nil)
				return
			}
			guard let movies = try? JSONDecoder().decode(MovieList.self, from: data) else {
				completion(nil)
				return
			}
			DispatchQueue.main.async {
				completion(movies.results)
			}
		}.resume()
	}
	
	private func loadDataByAlamofire(_ completion: @escaping ([Movie]?) -> Void) {
		Alamofire.request("\(api_url_base)\(api_key)")
			.responseJSON{ response in
				guard let data = response.data else {
					completion(nil)
					return
				}
				guard let movies = try? JSONDecoder().decode(MovieList.self, from: data) else {
					completion(nil)
					return
				}
				DispatchQueue.main.async {
					completion(movies.results)
				}
		}
	}
}
