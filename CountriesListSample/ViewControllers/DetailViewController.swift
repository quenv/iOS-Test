//
//  DetailViewController.swift
//  CountriesListSample
//
//  Created by SmartOSC on 10/25/18.
//  Copyright © 2018 QueNguyen. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderLabel: UILabel!
    
    
    // MARK: - Propeties
    var countryModel: CountryViewModel?
    var bordersList = [String]()

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        setupTableView()
    }
    
    // MARK: - Handle data
    private func bindData(){
        if let model = countryModel {
            title = model.name
            if let cacheImage = UIImage.getImageCacheFromURL(model.flagUrl) {
                flagImageView.image = cacheImage
            } else {
                flagImageView.image = UIImage(named: CLString.defaultImageName)
                UIImage.downloadImageFromUrl(model.flagUrl) {[weak self] (image) in
                    guard let strongSelf = self else { return }
                    guard let image = image else { return }
                    DispatchQueue.main.async {
                        strongSelf.flagImageView.image = image
                    }
                }
            }
            capitalLabel.text = model.capital
            regionLabel.text = model.region
            if let population = model.population {
                populationLabel.text = "\(population)"
            }
            if let borders = model.borders, borders.count > 0 {
                placeholderLabel.isHidden = true
                bordersList = borders
                tableView.reloadData()
            } else {
                placeholderLabel.isHidden = false
                placeholderLabel.text = CLString.placeholderName
                tableView.isHidden = true
            }
        }
    }
    
    // MARK: - Setup View
    private func setupTableView(){
        tableView.register(UINib(nibName: BorderCell.className, bundle: nil), forCellReuseIdentifier: BorderCell.className)
        tableView.delegate = self
        tableView.dataSource = self
    }

}


// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {

}


// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bordersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BorderCell.className, for: indexPath) as? BorderCell else {
            return UITableViewCell()
        }
        cell.borderNameLabel.text = bordersList[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
}
