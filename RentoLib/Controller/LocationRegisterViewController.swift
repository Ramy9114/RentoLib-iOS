//
//  LocationRegisterViewController.swift
//  RentoLib
//
//  Created by Rami Moubayed on 23/02/2021.
//

import UIKit

class LocationRegisterViewController: UIViewController {
    @IBOutlet weak var CountryTextField: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var ZipCodeTextField: UITextField!
    @IBOutlet weak var FirstAddressTextField: UITextField!
    @IBOutlet weak var FirstAddressComplementTextField: UITextField!
    @IBOutlet weak var SecondAddressTextField: UITextField!
    @IBOutlet weak var SecondAddressComplementTextField: UITextField!
    
    var registrationManager = RegistrationManager()
    var newUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registrationManager.delegate = self
    }
    
    @IBAction func RegisterPressed(_ sender: Any) {
        if CountryTextField.text?.count == 0 ||
            CityTextField.text?.count == 0 ||
            ZipCodeTextField.text?.count == 0 ||
            FirstAddressTextField.text?.count == 0 ||
            FirstAddressComplementTextField.text?.count == 0 ||
            SecondAddressTextField.text?.count == 0 ||
            SecondAddressComplementTextField.text?.count == 0
        {
            self.showToast(message: "Missing Fields", font: .systemFont(ofSize: 20.0))
        }else{
            //Create an instance of the user
//            newUser?.country = CountryTextField.text!
            newUser?.userLocation?.city?.name = CountryTextField.text!
            newUser?.userLocation?.zipCode = Int(ZipCodeTextField.text!)!
            newUser?.userLocation?.address = FirstAddressTextField.text!
            newUser?.userLocation?.complementAddress = FirstAddressComplementTextField.text!
            newUser?.userLocation?.addressTwo = SecondAddressTextField.text!
            newUser?.userLocation?.complementAddressTwo = SecondAddressComplementTextField.text!

//            registrationManager.createUser(newUser!, completion: { result in
//                switch result {
//                case .failure(let error):
//                    print("I AM PRINTING HERE")
//                    print("An error occured \(error.localizedDescription.debugDescription)")
//                    print("An error occured \(error.localizedDescription.description)")
//                case .success(let newUser):
//                    print("New user object with First Name: \(newUser.firstName) has been sent!")
//
//                }
//
//            })
            
            registrationManager.createUser(newUser!)
        }
        
        
//
    }
    
}

//MARK: - Show Toast Function
extension LocationRegisterViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-500, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: - LoginManagerDelegate
extension LocationRegisterViewController: RegistrationManagerDelegate {
    func RegistrationAuthenticated(_ registrationManager: RegistrationManager, _ JsonResponseMessage: String) {
        //create a segue and pass the user model alongside it
        //we will go here to the login page or homepage ???
        
//        print("Attempting Segue")
//        if JsonResponseMessage == "Username already exists in the database, please try another one" {
//            self.showToast(message: "User Already Exists", font: .systemFont(ofSize: 15.0))
//        }else {
        
            print(JsonResponseMessage)
            self.performSegue(withIdentifier: "goToLogin", sender: self)
//        }
    }
    
    func RegistrationFailWithError(errorMessage: String) {
        print("Printing the error")
        self.showToast(message: errorMessage, font: .systemFont(ofSize: 15.0))
    }

}

//MARK: - Segue Prepare function
extension LocationRegisterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLogin" {
            let destinationVC = segue.destination as! UINavigationController
            let slideVC = destinationVC.topViewController as! LoginViewController
//            let destinationVC = segue.destination as! LoginViewController
//            destinationVC.userObject = newUser

        }
    }


}
