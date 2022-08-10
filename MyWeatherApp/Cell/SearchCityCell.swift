//
//  SearchCityCell.swift
//  MyWeatherApp
//
//  Created by Doolot on 25/2/22.
//

import Foundation
import UIKit
import SnapKit
class SearchCityCell: UITableViewCell {
    private lazy var viewBackground: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "BackgroundBlueTableViewCell")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private lazy var cityName: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.text = "Bishkek"
        return view
    }()
    private lazy var cityType: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.text = "City"
        return view
    }()
    private lazy var cityCountry: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.text = "Kyrgyzstan"
        return view
    }()
    
    
    override func layoutSubviews() {
        
        
        addSubview(viewBackground)
        viewBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        viewBackground.addSubview(cityName)
        cityName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
        }
        viewBackground.addSubview(cityType)
        cityType.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
        }
        viewBackground.addSubview(cityCountry)
        cityCountry.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-8)
        }
    }
    func fill (model: SearchModel?) {
        cityName.text = model?.localizedName
        cityType.text = model?.type
        cityCountry.text = model?.country?.localizedName
    }
}
