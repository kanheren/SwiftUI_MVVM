//
//  ServiceProtocol.swift
//  Swiftui_movie
//
//  Created by Liem Vo on 12/1/19.
//  Copyright © 2021. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
	func fetchPopularMovies(completion: @escaping ([Movie]?) -> Void)
}
