//
//  ElementsCell.swift
//  Elements
//
//  Created by TingxinLi on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsCell: UITableViewCell {

    
    @IBOutlet weak var smallPicture: UIImageView!
    
    @IBOutlet weak var nameOfElements: UILabel!
    
    @IBOutlet weak var detailOfElement: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    public func configureCell(element: ElementsData) {
        
        nameOfElements.text = element.name
        detailOfElement.text = (element.symbol + "(" + String(element.number) + ")" + " " + String(element.atomic_mass))

           activityIndicator.startAnimating()
        
        ImageHelper.shared.fetchImage(urlString: "http://www.theodoregray.com/periodictable/Tiles/\(newNumber(number: element.number))/s7.JPG") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                
                self.smallPicture.image = image
                
            }
        }
                self.activityIndicator.stopAnimating()
            }
    
  





}
