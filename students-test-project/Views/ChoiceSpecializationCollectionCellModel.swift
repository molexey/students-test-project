//
//  ChoiceSpecializationCollectionCellModel.swift
//  students-test-project
//
//  Created by molexey on 12.02.2023.
//

import UIKit

class ChoiceSpecializationCollectionCellModel {
    
    // MARK: - Public properties
    
    let title: String
    
    // MARK: - Public inits
    
    init(_ title: String) {
        self.title = title
    }
        
    let reuseIdentifier: String = ChoiceSpecializationCollectionViewCell.reuseId
    var selected: Bool = false
    var editable: Bool = false
    var movable: Bool = false
    
    func cellForCollectionView(collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChoiceSpecializationCollectionViewCell
        cell.configure(withModel: self)
        
        return cell
    }
}
