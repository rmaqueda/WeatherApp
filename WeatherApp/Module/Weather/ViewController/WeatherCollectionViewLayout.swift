//
//  WeatherCollectionViewLayout.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//
// https://developer.apple.com/documentation/uikit/views_and_controls/collection_views/implementing_modern_collection_views

import Foundation
import UIKit

class WeatherCollectionViewLayout {
    
    func createLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            let section = WeatherViewSectionType.allCases[sectionIndex]
            
            switch sectionIndex {
            case 0:
                return self.oneItemLayout(itemHeight: section.size.height)
            case 1:
                return self.oneItemLayout(itemHeight: section.size.height)
            case 2:
                return self.horizoltalScrollLayout(iteSize: section.size, numberItems: section.numberOfItems)
            case 3:
                return self.oneItemLayout(itemHeight: section.size.height)
            default:
                return nil
            }
        }
    }
    
    func oneItemLayout(itemHeight: CGFloat) -> NSCollectionLayoutSection {
        let group = ForecastLayoutGroup(items: 1,
                                        itemWidth: .fractionalWidth(1),
                                        itemHeight: .absolute(itemHeight),
                                        direction: .vertical)
        
        let section = NSCollectionLayoutSection(group: group.layout)
        
        return section
    }
    
    func horizoltalScrollLayout(iteSize: CGSize, numberItems: Int) -> NSCollectionLayoutSection {
        let group = ForecastLayoutGroup(items: numberItems,
                                        itemWidth: .absolute(iteSize.width),
                                        itemHeight: .absolute(iteSize.height),
                                        direction: .horizontal,
                                        contentInsets: NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2))
        
        let section = NSCollectionLayoutSection(group: group.layout)
        section.orthogonalScrollingBehavior = .continuous

        return section
    }
    
}

struct ForecastLayoutGroup {
    let items: Int
    let itemWidth: NSCollectionLayoutDimension
    let itemHeight: NSCollectionLayoutDimension
    let direction: Direction
    var contentInsets: NSDirectionalEdgeInsets?
    
    enum Direction {
        case vertical
        case horizontal
    }
    
    var layout: NSCollectionLayoutGroup {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        if let conteInsets = contentInsets {
            item.contentInsets = conteInsets
        }
        var groupWidth: NSCollectionLayoutDimension
        if items == 1 {
            groupWidth = itemWidth
        } else {
            let widthInsets = (contentInsets?.leading ?? 0) + (contentInsets?.trailing ?? 0)
            groupWidth = .absolute(CGFloat(items) * (itemWidth.dimension - widthInsets))
        }
    
        let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: itemHeight)
        
        var layoutGroup: NSCollectionLayoutGroup
        switch direction {
        case .vertical:
            layoutGroup = .vertical(layoutSize: groupSize, subitem: item, count: items)
        case .horizontal:
            layoutGroup = .horizontal(layoutSize: groupSize, subitem: item, count: items)
        }
        
        return layoutGroup
    }
    
}
