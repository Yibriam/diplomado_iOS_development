//
//  CountriesViewController.swift
//  countryInformation
//
//  Created by Yibriam on 05/12/25.
//

import UIKit

final class CountriesViewController: UIViewController, UICollectionViewDelegate {
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, Country>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupCollection()
        applySnapshot()
    }
    
    private func setupCollection() {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                                  heightDimension: .estimated(120))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(140))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(CountryCell.self, forCellWithReuseIdentifier: CountryCell.reuseId)
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        dataSource = UICollectionViewDiffableDataSource<Int, Country>(collectionView: collectionView) { collectionView, indexPath, country in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseId, for: indexPath) as! CountryCell
            cell.configure(with: country)
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Country>()
        snapshot.appendSections([0])
        snapshot.appendItems(DataProvider.shared.countries)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let country = dataSource.itemIdentifier(for: indexPath) else { return }
        let detail = CountryDetailViewController(countryName: country.nombre)
        let nav = UINavigationController(rootViewController: detail)
        nav.modalPresentationStyle = .formSheet
        present(nav, animated: true, completion: nil)
    }
}

final class CountryCell: UICollectionViewCell {
    static let reuseId = "CountryCell"
    
    private let flagImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.clipsToBounds = true
        flagImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        
        let stack = UIStackView(arrangedSubviews: [flagImageView, nameLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(with country: Country) {
        nameLabel.text = country.nombre
        if let flagCode = DataProvider.shared.flags[country.nombre],
           let image = UIImage(named: flagCode) {
            flagImageView.image = image
        } else {
            flagImageView.image = UIImage(systemName: "flag") // fallback SF Symbol
        }
    }
}
