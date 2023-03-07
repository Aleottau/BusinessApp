//
//  Coordinator.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    func initialController(with prensenter: ViewModel) -> UIViewController
}
class Coordinator {
    var navigation: UINavigationController
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension Coordinator: CoordinatorProtocol {
    
    func initialController(with viewModel: ViewModel) -> UIViewController {
        let HomeBusinnesViewController = HomeBusinnesViewController(viewModel: viewModel)
        navigation.setViewControllers([HomeBusinnesViewController], animated: false)
        return navigation
    }
}
