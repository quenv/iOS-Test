//
//  MainViewController.swift
//  CountriesListSample
//
//  Created by SmartOSC on 10/25/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import UIKit
import PKHUD

class MainViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // MARK: - Properties
    private let countryViewModelController = CountryViewModelController()
    private let imageLoadQueue = OperationQueue()
    private var imageLoadOperations = [IndexPath: ImageLoadOperation]()
    
    var isGroup = false
    var filteredCountries = [CountryViewModel]()
    var search = UISearchController(searchResultsController: nil)
    var dataFilterByRegion = DataTypeRegion()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        HUD.show(.progress)
        setupTableView()
        addSearchBar()
        getData()
    }
    
    // MARK: - Handle data
    private func getData(){
        countryViewModelController.retrieveCountries { [weak self] (success, error) in
            HUD.hide()
            guard let strongSelf = self else { return }
            if !success {
                DispatchQueue.main.async {
                    let title = CLMessage.titleError
                    if let error = error {
                        strongSelf.showError(title, message: error.localizedDescription)
                    } else {
                        strongSelf.showError(title, message: NSLocalizedString(CLMessage.retrieveError, comment: CLMessage.retrieveError))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Search bar
    fileprivate func addSearchBar() {
        search.searchResultsUpdater = self
        search.searchBar.placeholder = CLString.searchPlaceholder
        search.searchBar.tintColor = .white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        self.navigationItem.searchController = search
    }
    
    fileprivate func searchBarIsEmpty() -> Bool {
        return search.searchBar.text?.isEmpty ?? true
    }
    
    fileprivate func filterContentForSearchText(searchText: String) {
        filteredCountries = countryViewModelController.filterData(searchText)
        updateDataFilter()
        self.tableView.reloadData()
    }
    
    fileprivate func isFiltering() -> Bool {
        return search.isActive && !searchBarIsEmpty()
    }
    
    func updateDataFilter(){
        dataFilterByRegion = Dictionary(grouping: filteredCountries,
                                  by: { $0.region ?? CLString.emptyString })
    }
    
    func getListCountriesDict() -> DataTypeRegion {
        if isFiltering() {
            return dataFilterByRegion
        }
        return countryViewModelController.listDataByRegion(isGroupRegion: self.isGroup)    
    }
    
    // MARK: - Setup View
    private func setupTableView(){
        tableView.register(UINib(nibName: CountryCell.className, bundle: nil), forCellReuseIdentifier: CountryCell.className)
        tableView.register(UINib(nibName: CountryHeaderView.className, bundle: nil), forHeaderFooterViewReuseIdentifier: CountryHeaderView.className)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedSectionHeaderHeight = CLSize.headerHeight
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        }
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Handle action
    @IBAction func onClickChangeValueSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == SelectedFilterCountry.allCountries.rawValue {
            self.isGroup = false
        } else {
            self.isGroup = true
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case CLString.showDetailCountry:
            guard let indexPath = sender as? IndexPath else { return }
            guard let detailVC = segue.destination as? DetailViewController else { return }
            if isFiltering() {
                detailVC.countryModel = filteredCountries[indexPath.row]
            } else if let viewModel = countryViewModelController.viewModel(at: indexPath.row) {
                detailVC.countryModel = viewModel
            }
        default:
            break
        }
    }
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (self.isGroup) {
            return UITableView.automaticDimension
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if (self.isGroup) {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: CountryHeaderView.className) as? CountryHeaderView {
                let listCountriesDic = getListCountriesDict()
                let region = Array(listCountriesDic.keys)[section]
                headerView.titleLabel.text = !region.isEmpty ? region : CLString.unknown
                return headerView
            }
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: CLString.showDetailCountry, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let imageLoadOperation = imageLoadOperations[indexPath] else {
            return
        }
        imageLoadOperation.cancel()
        imageLoadOperations.removeValue(forKey: indexPath)
    }
    
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let listCountriesDict = getListCountriesDict()
        let listCountries = Array(listCountriesDict.values)[section]
        return listCountries.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return dataFilterByRegion.count
        }
        return countryViewModelController.listDataByRegion(isGroupRegion: self.isGroup).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryCell.className, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        let listCountriesDict = getListCountriesDict()
        let dataModel = Array(listCountriesDict.values)[indexPath.section]
        let viewModel = dataModel[indexPath.row]
        cell.configCell(viewModel)
        if let imageLoadOperation = imageLoadOperations[indexPath],
            let image = imageLoadOperation.image {
            cell.flagImageView.setRoundedImage(image)
        }
        else {
            let imageLoadOperation = ImageLoadOperation(url: viewModel.flagUrl)
            imageLoadOperation.completionHandler = { [weak self] (image) in
                guard let strongSelf = self else {
                    return
                }
                cell.flagImageView.setRoundedImage(image)
                strongSelf.imageLoadOperations.removeValue(forKey: indexPath)
            }
            imageLoadQueue.addOperation(imageLoadOperation)
            imageLoadOperations[indexPath] = imageLoadOperation
        }
        return cell
    }
    
    
}

// MARK: - UITableViewDataSourcePrefetching
extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if let _ = imageLoadOperations[indexPath] {
                return
            }
            if let viewModel = countryViewModelController.viewModel(at: (indexPath as NSIndexPath).row) {
                let imageLoadOperation = ImageLoadOperation(url: viewModel.flagUrl)
                imageLoadQueue.addOperation(imageLoadOperation)
                imageLoadOperations[indexPath] = imageLoadOperation
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard let imageLoadOperation = imageLoadOperations[indexPath] else {
                return
            }
            imageLoadOperation.cancel()
            imageLoadOperations.removeValue(forKey: indexPath)
        }
    }
}

//MARK: - Search result updating
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}


