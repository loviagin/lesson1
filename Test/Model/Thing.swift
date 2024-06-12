//
//  Thing.swift
//  Test
//
//  Created by Ilia Loviagin on 6/12/24.
//

import Foundation

struct Thing: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var title: String
    var description: String? = nil // ? - тип Optional. Он может быть равен nil
    var date: Date? = nil
}
