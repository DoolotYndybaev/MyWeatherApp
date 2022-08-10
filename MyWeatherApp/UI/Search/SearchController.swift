//
//  SearchController.swift
//  MyWeatherApp
//
//  Created by Doolot on 25/2/22.
//

import Foundation
import UIKit
import SnapKit
class SearchController: UIViewController {
    
    private lazy var searchField: UITextField = {
        let view = UITextField()
        view.layer.cornerRadius = 8
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 20)
        view.attributedPlaceholder =
        NSAttributedString(string: "City Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        view.leftViewMode = .always
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    }()
    private lazy var searchButton: UIButton = {
        let view = UIButton(type: .system)
        view.layer.cornerRadius = 8
        view.backgroundColor = .tertiarySystemFill
        view.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        view.tintColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.addTarget(self, action: #selector(clickSearch(view:)), for: .touchUpInside)
        return view
    }()
    private lazy var searchTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .tertiarySystemFill
        return view
    }()
    private lazy var viewBackground: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "BackgroundBlueTableViewCell")
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    private lazy var viewOnBackground = UIView()
    
    private var models: [SearchModel]? = nil
    
    @objc func clickSearch(view: UIButton) {
        getSearchCity()
    }
    
    
    private func getSearchCity() {
        var url = URLComponents(string: "http://dataservice.accuweather.com/locations/v1/cities/autocomplete")!
        url.queryItems = [
            URLQueryItem(name: "q", value: searchField.text ?? String()),
            URLQueryItem(name: "apikey", value: "VO9jkGVnMXyFdJTNVvpRrZG1ZyjnGbsc"),
            URLQueryItem(name: "language", value: "en"),
        ]
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let data = data {
                    let model = try JSONDecoder().decode([SearchModel].self, from: data)
                    
                    self.models = model
                    
                    DispatchQueue.main.async {
                        self.searchTableView.reloadData()
                    }
                    
                    dump(model)
                }
            } catch {
                
            }
        }.resume()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Градиент")!)
        
        view.addSubview(searchField)
        searchField.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(10)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(11)
        }
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(10)
            make.left.equalTo(searchField.snp.right).offset(10)
            make.right.equalToSuperview().offset(-16)
            make.height.equalToSuperview().dividedBy(11)
        }
        view.addSubview(searchTableView)
        searchTableView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom)
            make.left.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom).offset(10)
        }
    }
}

extension SearchController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models?[indexPath.row]
        
        if let model = model {
            UserDefaults.standard.set(model.key ?? String(), forKey: "City")
            UserDefaults.standard.set(model.localizedName ?? String(), forKey: "CityName")
            navigationController?.pushViewController(MainController(), animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 + 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models?[indexPath.row]
        let cell = SearchCityCell()
        
        cell.fill(model: model)
        
        return cell
    }
}
