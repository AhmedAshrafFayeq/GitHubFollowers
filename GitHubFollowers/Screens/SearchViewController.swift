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
    let padding: CGFloat = 50
    
    var isUsernameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView, usernameTextField, getFollowersButton)
        createDismissKeyboardTapGesture()
        configureLogoImageView()
        configureUsernameTextField()
        configureGetFollowersButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK : - View Component
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant:CGFloat   = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80

        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureUsernameTextField(){
        usernameTextField.delegate  = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameTextField.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    func configureGetFollowersButton(){
        getFollowersButton.addTarget(self, action: #selector(pushFollowersListViewController), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            getFollowersButton.heightAnchor.constraint(equalToConstant: padding)
        ])
    }
    
    // MARK : - View Actions
    @objc func pushFollowersListViewController(){
        guard isUsernameEntered else {
            presentGFAletOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 👀.", buttonTitle: "Ok")
            return
        }
        usernameTextField.resignFirstResponder()
        
        let followersListViewController         = FollowersListViewController(username: usernameTextField.text!)
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
