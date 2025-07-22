//
//  ViewController.swift
//  LoginProject
//
//  Created by GS Agrawal on 22/07/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var forgetUsernameBtnText: UIButton!
    @IBOutlet weak var forgotPasswordText: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func forgotUsernameBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgotUsernameOrPassword", sender: sender)
    }
    @IBAction func forgotPasswordBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "ForgotUsernameOrPassword", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else { return }
        
        if sender == forgotPasswordText {
            segue.destination.navigationItem.title = "Forgot Password"
        }
        else if sender == forgetUsernameBtnText {
            segue.destination.navigationItem.title = "Forgot Username"
        }
        else{
            segue.destination.navigationItem.title = usernameField.text
        }
    }


}

