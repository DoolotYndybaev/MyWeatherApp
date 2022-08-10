//
//  WeatherCell.swift
//  MyWeatherApp
//
//  Created by Doolot on 26/2/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class WeatehrCell: UITableViewCell {
    private lazy var viewBackground: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "BackgroundBlueTableViewCell")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private lazy var dayTemperatur: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.text = "15C day"
        return view
    }()
    private lazy var dayText: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        view.text = "15C day"
        return view
    }()
    private lazy var iconWeatehr: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(viewBackground)
        viewBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        viewBackground.addSubview(iconWeatehr)
        iconWeatehr.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(60)
        }
        viewBackground.addSubview(dayTemperatur)
        dayTemperatur.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    func fill(dayOne: DailyForecast?) {
        dayTemperatur.text = "\(dayOne?.temperature?.maximum?.value ?? 0)˚/ \(dayOne?.temperature?.minimum?.value ?? 0 )˚"
        
        //          nightTempiratur.text = "\(dayOne?.temperature?.minimum?.value ?? 0 )C"
        
        let icom = dayOne?.day?.icon
        
        if (icom ?? 0) > 9 {
            iconWeatehr.kf.setImage(with: URL(string: "https://developer.accuweather.com/sites/default/files/\((icom ?? 0))-s.png")!)
        } else {
            iconWeatehr.kf.setImage(with: URL(string: "https://developer.accuweather.com/sites/default/files/0\((icom ?? 0))-s.png")!)
        }
    }
}
