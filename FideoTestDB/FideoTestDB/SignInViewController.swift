//
//  SignInViewController.swift
//  FideoTestDB
//
//  Created by Student08 on 21/09/2023.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var welcomeLabel: UILabel! // Ajout d'un UILabel pour afficher le message de bienvenue
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.isHidden = true // Cacher le label de bienvenue au départ
    }
    
    @IBAction func signInBtn() {
        // Authentifier un utilisateur avec e-mail et mot de passe
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authResult, error) in
            if let error = error {
                print("Erreur d'authentification : \(error.localizedDescription)")
            } else {
                // Authentification réussie, authResult contient des informations sur l'utilisateur
                let user = authResult?.user
                print("Utilisateur authentifié avec UID : \(user?.uid ?? "N/A")")
                
                // Afficher le message de bienvenue avec le nom de l'utilisateur
                
                // Utilisation de la fonction pour récupérer le prénom d'un utilisateur
                self.getFirstNameForUser(userID: user?.uid ?? "not found") { (firstname) in
                    if let firstName = firstname {
                        print("Le prénom de l'utilisateur est : \(firstName)")
                        self.showWelcomeMessage(firstName)
                    } else {
                        print("Le prénom de l'utilisateur n'a pas été trouvé.")
                    }
                }
               
                // Instaurer un délai de 3 secondes avant de cacher le message de bienvenue
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.hideWelcomeMessage()
                    self.redirectToMainViewController()
                }
            }
        }
    }
    
    //fermeture de la modal
    @IBAction func closeModalTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // Fonction pour afficher le message de bienvenue
    func showWelcomeMessage(_ name: String) {
        welcomeLabel.text = "Bienvenue, \(name)!"
        welcomeLabel.isHidden = false
    }
    
    // Fonction pour cacher le message de bienvenue
    func hideWelcomeMessage() {
        welcomeLabel.isHidden = true
    }
    
    // Fonction pour rediriger vers MainViewController
    func redirectToMainViewController() {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController")
        else {
            fatalError("Unable to instantiate MainViewController")
        }
        self.present(viewController, animated: true)
    }
    // récupérer le nom de l'utilisateur sur bas de l'UID
    func getFirstNameForUser(userID: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("user").document(userID)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(),
                   let firstName = data["firstname"] as? String {
                    completion(firstName)
                } else {
                    completion(nil) // Le prénom n'a pas été trouvé
                }
            } else {
                completion(nil) // L'utilisateur n'a pas été trouvé
            }
        }
    }
}
