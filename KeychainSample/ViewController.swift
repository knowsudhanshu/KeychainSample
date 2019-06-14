//
//  ViewController.swift
//  KeychainSample
//
//  Created by Sudhanshu Sudhanshu on 13/06/19.
//  Copyright © 2019 Sudhanshu Sudhanshu. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class ViewController: UIViewController {

    fileprivate func setupUI() {
        let createButton = getButtonObj(title: "Create", action: createAction)
        createButton.addTarget(self, action: #selector(createAction), for: .touchUpInside)
        
        let readButton = getButtonObj(title: "Read", action:readAction)
        readButton.addTarget(self, action: #selector(readAction), for: .touchUpInside)
        
        let updateButton = getButtonObj(title: "Update", action:updateAction)
        updateButton.addTarget(self, action: #selector(updateAction), for: .touchUpInside)
        
        let deleteButton = getButtonObj(title: "Delete", action:deleteAction)
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [createButton, readButton, updateButton, deleteButton])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        view.addSubview(stackView)
        stackView.fillSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Keychain CRUD"

        setupUI()
    }
    
    func getButtonObj(title: String, action: (()->Void)) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.random
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    let USER_ID = "USER_ID"
    @objc private func createAction() {
        
        if KeychainWrapper.standard.set("It's Sudhanshu's user id", forKey: USER_ID) {
            print("createAction success")
        }else {
            print("createAction failed")
        }
        
    }
    
    @objc private func readAction() {
        let userId = KeychainWrapper.standard.string(forKey: USER_ID)
        print("readAction: \(String(describing: userId))")
    }
    
    @objc private func updateAction() {
        if KeychainWrapper.standard.set("Updated It's Sudhanshu's user id", forKey: USER_ID) {
            print("updateAction success")
        }else {
            print("updateAction failed")
        }
    }
    
    @objc private func deleteAction() {
        if KeychainWrapper.standard.remove(key: USER_ID) {
            print("deleteAction success")
        }else {
            print("deleteAction failed")
        }
    }

}

extension UIView {
    func fillSuperview(_ margin: CGFloat = 0) {
        guard let superview = superview else { return }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -margin),
            self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -margin)
        ])
    }
}

extension UIColor {
    static var random: UIColor {
        let r = CGFloat.random(in: 0...1)
        let g = CGFloat.random(in: 0...1)
        let b = CGFloat.random(in: 0...1)
        let a = CGFloat.random(in: 0.8...1)
        
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
