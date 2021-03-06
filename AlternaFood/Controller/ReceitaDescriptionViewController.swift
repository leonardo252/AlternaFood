//
//  ReceitaDescriptionViewController.swift
//  AlternaFood
//
//  Created by Leonardo Gomes Fernandes on 30/11/20.
//

import UIKit

class ReceitaDescriptionViewController: UIViewController {

    let descriptionView = DescriptionView()
    let headerImage = HeaderImageView()
    
    var substituto: Substituto?
    
//    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.navigationBar.barStyle = .black
//    }
//
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        DispatchQueue.main.async {
            self.configDescriptionView()
        }
        configNav()
        configHeaderImageView()
        
        guard let substit = substituto else { return }
        headerImage.imageHeader.image = UIImage(named: substit.pathImageSubstituto ?? "jacaFoto")
        descriptionView.substituto = substit
    }

    func configNav() {
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "actionColor2")

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.tintColor = UIColor.init(named: "actionColor")
    }
    
    func configHeaderImageView() {
        view.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32),
            headerImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        ])
    }
    
    func configDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            descriptionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.70),
            descriptionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)
        ])
    }

}
