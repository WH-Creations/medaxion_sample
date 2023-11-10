//
//  HomeViewController.swift
//  medaxion_sample
//
//  Created by Casey West on 11/9/23.
//

import UIKit

import UIKit

class HomeViewController: UICollectionViewController {
    
    //MARK: - Properties
    let refreshControl = UIRefreshControl()
    private var viewModel: HomeViewModelProtocol!
    private let sectionInsets = UIEdgeInsets(top: 14.0, left: 14.0, bottom: 14.0, right: 14.0)
    private var itemsPerRow: CGFloat = 2
    private let reuseIdentifier = "homeCollectionViewCell"
    
    //MARK: - Lifecycle
    // Initialize HomeViewController with a MarvelApiServiceProtocol
    init(marvelApiService: MarvelApiServiceProtocol, layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        self.viewModel = HomeViewModel(marvelApiService: marvelApiService)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupCollectionView()
        setupRefreshControl()
        refreshCharacterList()
    }
    
    //MARK: - Setup
    func setupView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "Marvel Characters"
    }
    
    func setupCollectionView() {
        self.collectionView.register(UINib(nibName:"HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func setupRefreshControl() {
        refreshControl.tintColor = .lightGray
        refreshControl.addTarget(self, action: #selector(refreshCharacterListAction), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
    }
    
    @objc private func refreshCharacterListAction() {
        refreshCharacterList()
    }

    /**
     - Perform API call to load more characters
     - parameters:
        - offset: Starting position of API call
     */
    private func refreshCharacterList() {
        viewModel.refreshCharacterList { [weak self] result in
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                switch result {
                case .success(_):
                    self?.collectionView.reloadData()
                case .failure(let error):
                    // Handle the error, e.g., show an alert
                    print(error.localizedDescription) // Placeholder for proper error handling
                }
            }
        }
    }
    
    // MARK: - UICollectionView Datasource & Delegate
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characterList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Expected `\(HomeCollectionViewCell.self)` type for reuseIdentifier \(reuseIdentifier). Check the configuration in Interface Builder.")
        }
        
        let character = viewModel.characterList[indexPath.row]
        cell.character = character
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Navigate to character details
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characterList.count - 1 && !viewModel.isLoading {
            viewModel.loadCharacterList(offset: viewModel.characterList.count, completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self?.collectionView.reloadData()
                    case .failure(let error):
                        // Handle the error, e.g., show an error placeholder or something similar
                        print(error.localizedDescription)
                    }
                }
            })
        }
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 28)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

