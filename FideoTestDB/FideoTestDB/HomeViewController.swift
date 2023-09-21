//
//  ViewController.swift
//  FideoTestDB
//
//  Created by Student08 on 21/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //navigation vers la connexion
    @IBAction func signInTap(_ sender: Any) {
        let signInViewController =
        storyboard?.instantiateViewController(identifier:
                                                "SignInViewController")
        
        signInViewController?.modalPresentationStyle = .fullScreen

        present(signInViewController!, animated: true, completion:
                    nil)
    }
    
    //navigation vers l'inscription
    @IBAction func signUpTap(_ sender: Any) {
        let signUpViewController =
        storyboard?.instantiateViewController(identifier:
                                                "SignUpViewController")
        
        signUpViewController?.modalPresentationStyle = .fullScreen

        present(signUpViewController!, animated: true, completion:
                    nil)
    }
    
}

