//
//  ViewController.swift
//  PizzaFinder
//
//  Created by Rachel Saunders on 12/01/2020.
//  Copyright © 2020 Rachel Saunders. All rights reserved.
//

import UIKit

class AnnotationDetailViewController: UIViewController {
    var annotation:PizzaAnnotation!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pizzaPhoto: UIImageView!
    @IBOutlet weak var informationText: UITextView!
    
    @IBAction func done(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = annotation.title
        pizzaPhoto.image = annotation.pizzaPhoto
        informationText.text = annotation.informationText
        // Do any additional setup after loading the view.
    }

    

}
