//
//  ElementsDetailViewController.swift
//  Elements
//
//  Created by TingxinLi on 1/4/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class ElementsDetailViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var elementsImage: UIImageView!
    
    @IBOutlet weak var symbol: UILabel!
    
     @IBOutlet weak var number: UILabel!
    
     @IBOutlet weak var weight: UILabel!
     @IBOutlet weak var meltingPoint: UILabel!
     @IBOutlet weak var boilingPoint: UILabel!
     @IBOutlet weak var discoverBy: UILabel!

    public var element: ElementsData! 
    override func viewDidLoad() {
        super.viewDidLoad()
        symbol.text = element.symbol
        number.text = String(element.number)
        weight.text = String(element.atomic_mass)
        
        if let melting = element.melt {
            meltingPoint.text = String(element.melt!)
        }else {
            meltingPoint.text = "NO Value"
        }
        
        if let boiling = element.boil {
            boilingPoint.text = String(element.boil!)
        }else {
            boilingPoint.text = "NO Value"
        }
        discoverBy.text = element.discovered_by
        title = element.name
      updateImage()
    }
    private func updateImage() {
        let image = ImageHelper.shared.fetchImage(urlString: "http://images-of-elements.com/\(element.name.lowercased()).jpg") { (appError, image) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let image = image {
                
                    self.elementsImage.image = image
                
            }
    }
}
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func addToFavorites(_ sender: UIBarButtonItem) {
        
        
        
        let favorite = Favorite.init(name: element.name, symbol: element.symbol, atomic_mass: element.atomic_mass, spectral_img: element.spectral_img!)
        
        do {
            let data = try JSONEncoder().encode(favorite)
            ElementsAPIClient.favoriteElements(data: data) { (appError, success) in
                if let appError = appError {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error Message", message: appError.errorMessage())
                    }
                } else if success {
                    DispatchQueue.main.async {
                        self.showAlert(title: "successfully favorited elements", message: "")
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert(title: "was not favorited", message: "")
                    }
                }
            }
        } catch {
            print("encoding error: \(error)")
        }
    }
}

