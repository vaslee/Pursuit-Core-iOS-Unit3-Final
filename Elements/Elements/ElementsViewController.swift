//
//  ViewController.swift
//  Elements
//
//  Created by Alex Paul on 12/31/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import UIKit

class ElementsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    private var elements = [ElementsData]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    searchElements(keyword: "Elements")
    tableView.dataSource = self
    tableView.delegate = self
    
  }
    private func searchElements(keyword: String) {
        ElementsAPIClient.searchElements(keyword: keyword) { (appError, elements) in
            if let appError = appError {
                print(appError.errorMessage())
            } else if let elements = elements {
                self.elements = elements
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow,
            let detailViewController = segue.destination as? ElementsDetailViewController else {
                fatalError("indexPath, detailVC nil")
        }
        let element = elements[indexPath.row]
        detailViewController.element = element
    }
}

extension ElementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElementsCell", for: indexPath) as? ElementsCell else {
            fatalError("ElementsCell error")
        }
        let element = elements[indexPath.row]
        cell.configureCell(element: element)
        
        return cell
    }
}

extension ElementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



