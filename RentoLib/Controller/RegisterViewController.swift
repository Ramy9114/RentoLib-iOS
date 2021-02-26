//
//  RegisterViewController.swift
//  RentoLib
//
//  Created by Rami Moubayed on 22/02/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var FirstNameTextField: UITextField!
    @IBOutlet weak var MiddleNameTextField: UITextField!
    @IBOutlet weak var LastNameTextField: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    @IBOutlet weak var PhoneNumberTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    
    
    var registrationManager = RegistrationManager()
    
    var newUser: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func NextPressed(_ sender: UIButton) {
        if FirstNameTextField.text?.count == 0 ||
            MiddleNameTextField.text?.count == 0 ||
            LastNameTextField.text?.count == 0 ||
            AgeTextField.text?.count == 0 ||
            PhoneNumberTextField.text?.count == 0 ||
            EmailTextField.text?.count == 0 ||
            UsernameTextField.text?.count == 0 ||
            PasswordTextField.text?.count == 0 ||
            ConfirmPasswordTextField.text?.count == 0
        {
            self.showToast(message: "Missing Fields", font: .systemFont(ofSize: 20.0))
        }else if PasswordTextField.text != ConfirmPasswordTextField.text{
            self.showToast(message: "Passwords don't match", font: .systemFont(ofSize: 10.0))

        }else{
            //Create an instance of the user
            newUser = User(userId: 0,
                           firstName: FirstNameTextField.text!,
                           middleName: MiddleNameTextField.text!,
                           lastName: LastNameTextField.text!,
                           age: Int(AgeTextField.text!)!,
                           telephone: PhoneNumberTextField.text!,
                           username: UsernameTextField.text!,
                           email: EmailTextField.text!,
                           password: PasswordTextField.text!,
                           picture: "",
                           userLocation: UserLocation(userLocationId: 0,
                                                      userId: 0,
                                                      zipCode: 0,
                                                      address: "",
                                                      complementAddress: "",
                                                      addressTwo: "",
                                                      complementAddressTwo: "",
                                                      cityId: 1,
                                                      city: City(cityId: 1, name: "",
                                                                 country: Country(countryId: 0, name: ""))))
            
            

               //Create Segue and Pass User Data to the Location Register
            self.performSegue(withIdentifier: "goToLocationRegister", sender: self)
            
        }
    }
    
}


//MARK: - Show Toast Function
extension RegisterViewController {

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

//MARK: - Segue Prepare function
extension RegisterViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLocationRegister" {
            let destinationVC = segue.destination as! LocationRegisterViewController
            destinationVC.newUser = newUser
        }
    }
    
    
}


