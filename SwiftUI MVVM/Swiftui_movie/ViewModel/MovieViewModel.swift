//
//  NetworkManager.swift
//  Swiftui_movie
//
//  Created by Dinesh Mahesh Kumar.
//  Copyright © 2021. All rights reserved.
//


import Combine

class MovieViewModel: ObservableObject {
	@Published var movies = MovieList(results: [])
	@Published var loading = false

	let service: ServiceProtocol
	init(service: ServiceProtocol = APIService()) {
		self.service = service
	}
	
	func loadData() {
		self.loading = true
		service.fetchPopularMovies { movies in
			self.loading = false
			guard let movies = movies else {
				return
			}
			self.movies.results = movies
		}
	}
}
