//
//  HomeViewController.swift
//  RentoLib
//
//  Created by Rami Moubayed on 23/02/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var userObject: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(userObject!)
    }
    @IBAction func goRent(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToRentForm", sender: self)
    }
    
    @IBAction func goPost(_ sender: Any) {
        self.performSegue(withIdentifier: "goToPostForm", sender: self)
    }
    
}

//MARK: - Segue Prepare function
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRentForm" {
            let destinationVC = segue.destination as! SearchViewController
            destinationVC.userObject = userObject
            
        } else if segue.identifier == "goToPostForm"{
            let destinationVC = segue.destination as! PostViewController
            destinationVC.userObject = userObject
        }
    }
    
//    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    
}
