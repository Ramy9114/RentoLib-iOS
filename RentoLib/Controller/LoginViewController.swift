//
//  ViewController.swift
//  RentoLib
//
//  Created by Rami Moubayed on 22/02/2021.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var RentoLibLogoImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var dontHaveAccountLabel: UILabel!
    
    
    var loginManager = LoginManager()
    
    var userObject: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginManager.delegate = self
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if emailTextField.text?.count == 0 || passwordTextField.text?.count == 0 {
            self.showToast(message: "Missing Fields", font: .systemFont(ofSize: 20.0))
        } else {
            // call Login API
            let userAuth = UserAuthentication(username: emailTextField.text!, password: passwordTextField.text!)
            loginManager.authenticate(userAuth)
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        print("Going to Registration Controller")
    }
}

//MARK: - Show Toast Function
extension LoginViewController {

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
extension LoginViewController: LoginManagerDelegate {
    func LoginAuthenticated(_ loginManager: LoginManager, user: User, responseMessage: String) {
        //create a segue and pass the user model alongside it
        //we will go here to the home page
        userObject = user
        self.showToast(message: "Logging In...", font: .systemFont(ofSize: 20.0))
        self.performSegue(withIdentifier: "goToHome", sender: self)
    }
    
    func LoginFailWithError(errorMessage: String) {
        self.showToast(message: errorMessage, font: .systemFont(ofSize: 20.0))
    }
    
    
}

//MARK: - Segue Prepare function
extension LoginViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToHome" {
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.userObject = userObject
        }
    }
    
//    @IBAction func unwindToLogin(segue:UIStoryboardSegue) { }
    
    
}

