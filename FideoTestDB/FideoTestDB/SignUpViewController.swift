//
//  SignUpViewController.swift
//  FideoTestDB
//
//  Created by Student08 on 21/09/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import Firebase

class SignUpViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var usernametextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    //fermeture de la modal
    @IBAction func closeModalTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func signUpTap(_ sender: Any) {
        if(registrationIsValid()) {
            print("registered")
            saveData()
        } else {
            print("not okay")
        }
        
    }
    
    func errorAlertMessage(message: String) {
        let alert = UIAlertController(title: "ERROR", message: message, preferredStyle:
                .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
    func registrationIsValid() -> Bool {
        guard let username = usernametextField.text,
              let email = emailTextField.text,
              let lastname = lastnameTextField.text,
              let firstname =  firstnameTextField.text,
              let phoneNumber = phoneNumberTextField.text,
              let password = passwordTextField.text,
              let passwordConfirmation = passwordConfirmationTextField.text else { return false }
        
        guard !username.isEmpty else {
            errorAlertMessage(message: "Le nom d'utilisateur est vide")
            return false
        }
        
        guard !email.isEmpty, NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: email) else {
            errorAlertMessage(message: "L'email est invalide")
            return false
        }
        
        
        guard !lastname.isEmpty else {
            errorAlertMessage(message: "Le nom est vide")
            return false
        }
        
        guard !firstname.isEmpty else {
            errorAlertMessage(message: "Le prénom est vide")
            return false
        }
        
        guard !phoneNumber.isEmpty else {
            errorAlertMessage(message: "Le numéro de téléphone est vide")
            return false
        }
        
        guard !password.isEmpty else {
            errorAlertMessage(message: "Le mot de passe est vide est vide")
            return false
        }
        
        guard !passwordConfirmation.isEmpty, passwordConfirmation.count >= 6 else {
            errorAlertMessage(message: "Le mot de passe doit contenir au moins 6 caractères.")
            return false
        }
        
        guard password == passwordConfirmation else {
            errorAlertMessage(message: "Les mots de passe ne correspondent pas.")
            return false
        }
        
        return true
    }
    
    func saveData() {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            
            if let error = error {
                print("Erreur lors de la création du compte : \(error.localizedDescription)")
            } else if let authResult = authResult {
                print("Compte créé avec succès. UID de l'utilisateur : \(authResult.user.uid)")
                
                //modif
                
                /* Une fois le compte créé avec succès, enregistrez les données utilisateur dans Firestore.
                 let db = Firestore.firestore()
                 let user = authResult.user
                 
                 db.collection("Utilisateurs").document(user.uid).setData([
                 "nom": nom,
                 "prenom": prenom,
                 "age": age,
                 "ville": ville,
                 // Ajoutez d'autres données utilisateur selon vos besoins
                 ]) { error in
                 if let error = error {
                 print("Erreur lors de la création du document utilisateur : \(error.localizedDescription)")
                 } else {
                 print("Document utilisateur créé avec succès dans Firestore.")
                 }
                 }*/
                
            }
        }
        
    }
}
