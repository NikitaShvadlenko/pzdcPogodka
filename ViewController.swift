//
//  ViewController.swift
//  pzdcPogodka
//
//  Created by Nikita Shvad on 26.07.2021.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {
    private let scrollView = UIScrollView()
    //Почему view Background Color меняется, если прописать, а у contentView или у backgroundView не меняется? Я же их положил с backgroundView на самом верху.
    private var contentView = UIView()
    private var backgroundView = UIView()
    //Лейблы погоды - их нужно убрать отсюда.
    private var cityLabel = UILabel()
    private var temperatureLabel = UILabel()
    private var weatherLabel = UILabel()
    private var tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let locationManager = CLLocationManager()
    let navigationBar = UINavigationBar()
    
    override func viewDidLoad() {
        setupScrollView()
        setupWeatherView()
    }

    private func setupWeatherView() {
        view.backgroundColor = .gray
        cityLabel.text = "New Plymouth"
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cityLabel.numberOfLines = 1
        cityLabel.minimumScaleFactor = 0.1
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(cityLabel)
        
        weatherLabel.text = "На улице рейн"
        weatherLabel.font = UIFont.boldSystemFont(ofSize: 15)
        weatherLabel.numberOfLines = 1
        weatherLabel.minimumScaleFactor = 0.1
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.textAlignment = .center
        backgroundView.addSubview(weatherLabel)
        
        temperatureLabel.text = "13.00"
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = UIFont.boldSystemFont(ofSize: 30)
        temperatureLabel.numberOfLines = 1
        temperatureLabel.minimumScaleFactor = 0.1
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(temperatureLabel)
        
        tableView.backgroundColor = .red
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherCell.self, forCellReuseIdentifier: "WeatherCell")
        setupConstraints()
        backgroundView.addSubview(tableView)
    }

}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell
        cell?.configure(dayOfWeek: "МАНДАЙ", chanceOfRain: "100%", highTemp: "16", lowTemp: "12")
        return cell!
    }
}
//MARK: - RefreshControl
extension ViewController {
    @objc func refresh(_ sender: AnyObject) {
        temperatureLabel.text = "FRESHFRESH"
        refreshControl.endRefreshing()
    }
}
//MARK: - ScrollView
extension ViewController{
    func setupScrollView() {

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(backgroundView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
         //refreshControl
         refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .allEvents)
         scrollView.addSubview(refreshControl)
         scrollView.alwaysBounceVertical = true

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        backgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}
//MARK: - CLLocation
extension ViewController{

}
//MARK: - Alerts
extension ViewController{
    func locationAlert(alertTitle:String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Setting", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString){ UIApplication.shared.open(url, options: [:], completionHandler: nil)}
                }
                alertController.addAction(openAction)
                self.present(alertController, animated: true, completion: nil)
    }
}
//MARK: - Setup Constraints
extension ViewController {
    func setupConstraints() {
        let cityLabelConstraints = [
            NSLayoutConstraint(item: cityLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 5),
            NSLayoutConstraint(item: cityLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40),
            NSLayoutConstraint(item: cityLabel, attribute: .left, relatedBy: .equal, toItem: backgroundView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: cityLabel, attribute: .right, relatedBy: .equal, toItem: backgroundView, attribute: .right, multiplier: 1, constant: 0)
        ]
        NSLayoutConstraint.activate(cityLabelConstraints)
        
        let weatherLabelConstraints = [
            NSLayoutConstraint(item: weatherLabel, attribute: .top, relatedBy: .equal, toItem: cityLabel, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 15),
            NSLayoutConstraint(item: weatherLabel, attribute: .left, relatedBy: .equal, toItem: backgroundView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherLabel, attribute: .right, relatedBy: .equal, toItem: backgroundView, attribute: .right, multiplier: 1, constant: 0)
        ]
        
        NSLayoutConstraint.activate(weatherLabelConstraints)
        
        let temperatureLabelConstraints = [
            NSLayoutConstraint(item: temperatureLabel, attribute: .top, relatedBy: .equal, toItem: weatherLabel, attribute: .bottom, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: temperatureLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30),
            NSLayoutConstraint(item: temperatureLabel, attribute: .left, relatedBy: .equal, toItem: backgroundView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: temperatureLabel, attribute: .right, relatedBy: .equal, toItem: backgroundView, attribute: .right, multiplier: 1, constant: 0)
        ]
        NSLayoutConstraint.activate(temperatureLabelConstraints)
        //Вообще мне тут не высота нужна, я к низу background view хотел прилепить, просто подумал, что прописать высоту решит мою проблему.
        let tableViewConstraints = [
            NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: temperatureLabel, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        ]
        NSLayoutConstraint.activate(tableViewConstraints)
        
    }
}
//MARK: - Navigation Bar
extension ViewController{
    func setupNavigationBar() {
        
    }
}
