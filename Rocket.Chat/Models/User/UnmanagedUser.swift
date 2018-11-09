//
//  UnmanagedUser.swift
//  Rocket.Chat
//
//  Created by Samar Sunkaria on 8/21/18.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import Foundation
import DifferenceKit

struct UnmanagedUser: UnmanagedObject, Equatable {
    typealias Object = User

    var identifier: String
    var username: String
    var name: String?
    var privateStatus: String
    var status: UserStatus
    var utcOffset: Double
    var avatarURL: URL?

    var managedObject: User? {
        return User.find(withIdentifier: identifier)?.validated()
    }
}

extension UnmanagedUser {
    init?(_ user: User) {
        guard
            let userUsername = user.username,
            let userIdentifier = user.identifier
        else {
            return nil
        }

        identifier = userIdentifier
        username = userUsername
        name = user.name
        privateStatus = user.privateStatus
        status = user.status
        utcOffset = user.utcOffset
        avatarURL = user.avatarURL()
    }
}

extension UnmanagedUser: Differentiable {
    typealias DifferenceIdentifier = String

    var differenceIdentifier: String {
        return username
    }
}