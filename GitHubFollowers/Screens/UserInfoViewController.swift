//
//  UserInfoViewController.swift
//  GitHubFollowers
//
//  Created by Ahmed Fayek on 9/29/20.
//  Copyright © 2020 Ahmed Fayek. All rights reserved.
//

import UIKit

protocol UserInfoViewControllerDelegate: class{
    func didRequestFollowers(for username: String)
}

class UserInfoViewController: GFDataLoadingViewController {

    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    var username: String!
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    weak var delegate: UserInfoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        getUserInfo()
        configureLayoutUI()
    }
    
    func configureViewController(){
        view.backgroundColor                = .systemBackground
        let doneButton                      = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem    = doneButton
    }
    
    func configureScrollView(){
        view.addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        scrollView.pintToEdges(of: view)
        contentView.pintToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: view.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let user):
                DispatchQueue.main.async { self.configureUIElements(with: user)}
            case .failure(let error):
                self.presentGFAletOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User){
        self.add(childVC: GFRepoItemViewController(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemViewController(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func configureLayoutUI(){
        let padding: CGFloat    = 20
        let itemHeight:CGFloat  = 140
        itemViews               = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints  = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
            ])
        }
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
           itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
           itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
           
           dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
           dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        self.dismiss(animated: true)
    }

}

extension UserInfoViewController: GFRepoItemViewControllerDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAletOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }
}

extension UserInfoViewController: GFFollowerItemViewControllerDelegate{
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else{
            presentGFAletOnMainThread(title: "No Followers", message: "This user has no followers. what a shame 😞", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
