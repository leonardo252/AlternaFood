//
//  ListaSubstitutosViewControllerExtension.swift
//  AlternaFood
//
//  Created by Nathalia Cardoso on 23/11/20.
//

import Foundation
import UIKit

extension ListaSubstitutosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func setUpCollectionview() {

        let layout = CustomCollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 30, left: 40, bottom: 100, right: 40)
//        layout.itemSize = CGSize(width: view.frame.width*0.37, height: view.frame.height*0.27)

        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)

        view.addSubview(collectionView ?? UICollectionView())
        setCollectionViewDelegates()
        collectionView?.backgroundColor = .systemBackground

        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "MyCell")
    }

    func setCollectionViewDelegates() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        substitutos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? CustomCell else {
            return UICollectionViewCell()
        }
        
        cell.card.name.text = substitutos[indexPath.row].nomeSubstituto ?? "Substituto"
        cell.card.icon.image = UIImage(named: substitutos[indexPath.row].pathIconSubstituto ?? "receitas_icon")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("User tapped on item \(indexPath.row)")
        let viewController = DescriptionViewController() //só substituir pela controller da descrição
        viewController.substituto = substitutos[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}