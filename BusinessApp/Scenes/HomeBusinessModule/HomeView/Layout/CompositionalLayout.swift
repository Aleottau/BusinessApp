//
//  CompositionalLayout.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit

class CompositionalLayout: NSObject {

    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1/6))
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item])
//            group.interItemSpacing = .fixed(5)
            let section = NSCollectionLayoutSection(group: group)
//            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        return layout
    }
}
