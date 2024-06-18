//
//  WellAssmntCoordinator.swift
//  WellAssesmentWithCoordinators
//
//  Created by Derrick Wilde on 6/18/24.
//

import Foundation

protocol Coordinator {
    // Ideally this would be driven by an enum
    var tag: String { get set }
    func start()
}
