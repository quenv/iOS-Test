//
//  DetailViewController.swift
//  CountriesListSample
//
//  Created by SmartOSC on 10/25/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var flagHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    // MARK: - Propeties
    var countryModel: CountryViewModel!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setupTableView()
        adjustFlagHeight()
    }
    
    // MARK: - Handle data
    private func bindData(){
        title = countryModel.name
        UIImage.downloadImageFromUrl(countryModel.flagUrl) {[weak self] (image) in
            guard let strongSelf = self else { return }
            guard let image = image else { return }
            DispatchQueue.main.async {
                strongSelf.flagImageView.image = image
                strongSelf.indicator.stopAnimating()
            }
        }
    }
    
    // MARK: - Setup View
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Flag image view
    fileprivate func adjustFlagHeight() {
        flagHeightConstraint.constant = view.frame.width / CLSize.scaleFlagImage
    }
    
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CLSize.numberDetail
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CLSize.oneRow
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case SectionDetail.capital.rawValue:
            return CLString.capitalSection
        case SectionDetail.region.rawValue:
            return CLString.regionSection
        case SectionDetail.population.rawValue:
            return CLString.populationSection
        case SectionDetail.nativeName.rawValue:
            return CLString.nativeNameSection
        default:
            return CLString.emptyString
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryGenericInfoTableViewCell.className, for: indexPath) as? CountryGenericInfoTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case SectionDetail.capital.rawValue :
            cell.infoLabel.text = countryModel.capital ?? CLString.noInfo
        case SectionDetail.region.rawValue:
            if let region = countryModel.region, !region.isEmpty {
                if let subregion = countryModel.subregion {
                    cell.infoLabel.text = "\(region), \(subregion)"
                } else {
                    cell.infoLabel.text = "\(region)"
                }
            } else {
                if let subregion = countryModel.subregion, !subregion.isEmpty {
                    cell.infoLabel.text = "\(subregion)"
                } else {
                    cell.infoLabel.text = CLString.noInfo
                }
            }
        case SectionDetail.population.rawValue:
            if let population = countryModel.population {
                cell.infoLabel.text = "\(population) hab."
            }
        case SectionDetail.nativeName.rawValue:
            if let nativeName = countryModel.nativeName {
                cell.infoLabel.text = String(format: "%@", nativeName)
            }
        default:
            break
        }
        
        return cell
    }
    
}
