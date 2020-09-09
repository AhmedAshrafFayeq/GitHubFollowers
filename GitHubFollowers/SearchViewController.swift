//
//  ViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/8/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let logoImageView       = UIImageView()
    let usernameTextField   = GFTextField()
    let getFollowersButton  = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        createDismissKeyboardTapGesture()
        configureLogoImageView()
        configureUsernameTextField()
        configureGetFollowersButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK : - View Component
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")!
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureUsernameTextField(){
        view.addSubview(usernameTextField)
        usernameTextField.delegate  = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureGetFollowersButton(){
        view.addSubview(getFollowersButton)
        getFollowersButton.addTarget(self, action: #selector(pushFollowersListViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK : - View Actions
    @objc func pushFollowersListViewController(){
        guard isUsernameEntered else {
            print("No Username Entered")
            return
        }
        
        let followersListViewController         = FollowersListViewController()
        followersListViewController.userName    = usernameTextField.text
        followersListViewController.title       = usernameTextField.text
        navigationController?.pushViewController(followersListViewController, animated: true)
    }
    
    
}
    // MARK : - Extension UITextFieldDelegate
extension SearchViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersListViewController()
        return true
    }
}
