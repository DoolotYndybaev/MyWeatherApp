//
//  MainController.swift
//  MyWeatherApp
//
//  Created by Doolot on 25/2/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher
class MainController: UIViewController {
    
    private lazy var titleCity: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.text = "Bishkek"
        return view
    }()
    private lazy var newCityButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "plus.square.dashed"), for: .normal)
        view.tintColor = .white
        view.clipsToBounds = true
        view.addTarget(nil, action: #selector(addTapped(sender:)), for: .touchUpInside)
        view.alpha = 1
        return view
    }()
    private lazy var settingsCityButton: UIButton = {
        let view = UIButton(type: .system)
        view.setBackgroundImage(UIImage(systemName: "gearshape"), for: .normal)
        view.tintColor = .white
        view.alpha = 1
        return view
    }()
    private lazy var iconTemp: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    private lazy var temperatureLabelText: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.text = "Сегодня"
        return view
    }()
    private lazy var temperatureLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        view.text = "15C/5C"
        return view
    }()
    private lazy var averageTemperatureLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 65, weight: .bold)
        view.text = "Average 10C"
        return view
    }()
    private lazy var weatherForFourText: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.adjustsFontSizeToFitWidth = true
        view.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        view.text = "Прогноз на следующие 4 дня"
        return view
    }()
    
    private lazy var dayForCastTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .tertiarySystemFill
        view.layer.cornerRadius = 15
        view.alpha = 0.7
        return view
    }()
    var dailyForecasts: [DailyForecast]? = nil
    
    
    override func viewDidLoad() {
        view.backgroundColor = .darkGray
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Градиент")!)
        
        
        view.addSubview(titleCity)
        titleCity.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeArea.top).offset(20)
        }
        view.addSubview(newCityButton)
        newCityButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeArea.top).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        view.addSubview(settingsCityButton)
        settingsCityButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeArea.top).offset(20)
            make.right.equalToSuperview().offset(-20)
            make.width.height.equalTo(25)
        }
        view.addSubview(averageTemperatureLabel)
        averageTemperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().dividedBy(6)
            make.top.equalTo(self.titleCity.snp.bottom).offset(30)
            make.width.equalToSuperview().dividedBy(3)
        }
        view.addSubview(iconTemp)
        iconTemp.snp.makeConstraints { make in
            make.top.equalTo(averageTemperatureLabel.snp.bottom)
            make.left.equalToSuperview().offset(30)
            make.height.width.equalTo(50)
        }
        view.addSubview(temperatureLabelText)
        temperatureLabelText.snp.makeConstraints { make in
            make.top.equalTo(averageTemperatureLabel.snp.bottom).offset(5)
            make.left.equalTo(iconTemp.snp.right).offset(10)
            make.width.equalToSuperview().dividedBy(4)
        }
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(averageTemperatureLabel.snp.bottom).offset(5)
            make.right.equalToSuperview().offset(-30)
            make.width.equalToSuperview().dividedBy(3)
        }
        view.addSubview(weatherForFourText)
        weatherForFourText.snp.makeConstraints { make in
            make.top.equalTo(iconTemp.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(30)
        }
        view.addSubview(dayForCastTableView)
        dayForCastTableView.snp.makeConstraints { make in
            make.top.equalTo(weatherForFourText.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalTo(view.safeArea.bottom).offset(-30)
        }
        getWeather()
    }
    private func getWeather() {
        let cityKey = UserDefaults.standard.string(forKey: "City")!
        var url = URLComponents(string: "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(cityKey)")!
        url.queryItems = [
            URLQueryItem(name: "apikey", value: "VO9jkGVnMXyFdJTNVvpRrZG1ZyjnGbsc"),
            URLQueryItem(name: "language", value: "en"),
            URLQueryItem(name: "details", value: "false"),
            URLQueryItem(name: "metric", value: "true"),
        ]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let model = try JSONDecoder().decode(WeatherModel.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.setupView(model: model)
                    }
                    
                    dump(model)
                }
            } catch {
                
            }
        }.resume()
    }
    func setupView(model: WeatherModel?) {
        titleCity.text = UserDefaults.standard.string(forKey: "CityName")
        let dayOne = model?.dailyForecasts?[0]
        
        temperatureLabel.text = "\(dayOne?.temperature?.maximum?.value ?? 0)˚ / \(dayOne?.temperature?.minimum?.value ?? 0 )˚"
        
        let s = Int(((dayOne?.temperature?.maximum?.value ?? 0) + (dayOne?.temperature?.minimum?.value ?? 0 )) / 2)
        
        averageTemperatureLabel.text = "\(s)˚"
        
        let icom = dayOne?.day?.icon
        
        if (icom ?? 0) > 9 {
            iconTemp.kf.setImage(with: URL(string: "https://developer.accuweather.com/sites/default/files/\((icom ?? 0))-s.png")!)
        } else {
            iconTemp.kf.setImage(with: URL(string: "https://developer.accuweather.com/sites/default/files/0\((icom ?? 0))-s.png")!)
        }
        
        
        var newModel =  model?.dailyForecasts
        
        newModel?.remove(at: 0)
        
        self.dailyForecasts = newModel
        dayForCastTableView.reloadData()
    }
}
extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForecasts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dailyForecasts?[indexPath.row]
        let cell = WeatehrCell()
        
        cell.fill(dayOne: model)
        
        return cell
    }
    @objc func addTapped(sender: UIButton){
        if sender.imageView?.image == UIImage(systemName: "plus.square.dashed") {
            navigationController?.pushViewController(SearchController(), animated: true)
        }
    }
}
