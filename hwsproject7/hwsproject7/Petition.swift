//
//  Petition.swift
//  hwsproject7
//
//  Created by Enrique Florencio on 3/27/19.
//  Copyright © 2019 Enrique Florencio. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
