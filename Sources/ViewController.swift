//
//  ViewController.swift
//  pzdcPogodka
//
//  Created by Nikita Shvad on 26.07.2021.
//

import UIKit
import CoreLocation
import Moya

class ViewController: UIViewController {
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refreshControl
    }()
    private weak var headerView: WeatherHeaderView?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //Откуда взялись эти значения? Почему именно 44? На айпэде это выглядит очень маленьким экраном.
        tableView.rowHeight = 44
        // если я использую estimated rowHeigh, то нет смысла делать rowHeight. Лишняя строчка?
        tableView.estimatedRowHeight = 44
        tableView.estimatedSectionHeaderHeight = 102
        // При заданной высоте сам создаст нужную длинну
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.register(FixedWeatherCell.self, forCellReuseIdentifier: "\(FixedWeatherCell.self)")
        tableView.register(WeatherHeaderView.self, forHeaderFooterViewReuseIdentifier: "\(WeatherHeaderView.self)")
        return tableView
    }()

    private lazy var locationManager = CLLocationManager()
    //Эта var уже не lazy. Почему?
    private var weather: [Weather] = []
    private let weatherProvider = MoyaProvider<OpenWeatherRoute>()
    // didSet - Property Observer. Как только ты set значение этой var, начнется функция fetchWeather? Кайф.
    private var location: (latitude: Double, longitude: Double)? = nil {
        didSet {
            fetchWeather()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        locationManager.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weather.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "\(FixedWeatherCell.self)", for: indexPath) as? FixedWeatherCell
        let weather = self.weather[indexPath.row]
        weatherCell?.configure(weather: weather)
        cell = weatherCell
        //Проверяешь, чтобы оно было не nil
        guard let cell = cell else {
            fatalError("Can not dequeue cell")
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //Используется Switch на случай, если я добавлю еще секций, так мне нужно убедиться, что я для самой первой секции использую правильный View
        switch section {
        case 0:
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "\(WeatherHeaderView.self)") as? WeatherHeaderView
            self.headerView = headerView
            //тут уже не используется guard let, потому что WeatherHeaderView не будет nil, хотя и headerView сначала optional.
            return headerView

        default:
            return nil
        }
    }
}

//MARK: - Private methods
extension ViewController {
    //По сути весь view - tableView со своими cells и headerForSection
    private func setupViews() {
        view.backgroundColor = .gray
        view.addSubview(tableView)
        //tableView будет равен safe area. Почему на айпэде tableView сжимается? связанно ли это с tableView.sectionHeaderHeight = UITableView.automaticDimension ?
        let tableViewContraints = [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ]

        NSLayoutConstraint.activate(tableViewContraints)
    }
    @objc private func refresh(_ sender: UIRefreshControl?) {
        fetchWeather()
    }
    
    private func updateCity(_ city: String) {
        headerView?.setCity(city)
    }

    private func locationAlert(alertTitle:String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle , message: alertMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let openAction = UIAlertAction(title: "Open Setting", style: .default) { (action) in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }

    private func fetchWeather() {
        guard let location = self.location else { return }
        weatherProvider.request(.oneCall(latitude: location.latitude, longitude: location.longitude)) { [weak self] result in
            switch result {
            case let .success(response):
                do {
                    //создаешь декодер
                    let jsonDecoder = JSONDecoder()
                    //Так ты будешь декодить дату
                    jsonDecoder.dateDecodingStrategy = .secondsSince1970
                    //Пытаешься взять респонс??
                    let weatherResponse = try response.map(WeatherResponse.self, using: jsonDecoder, failsOnEmptyData: true)
                    //Вернет array of forecasts?
                    self?.weather = weatherResponse.forecasts.map { dayWeather in
                        Weather(day: dayWeather.date, temperature: dayWeather.temperature.day)
                    }
                    //Всю decoded дату используешь для обновления views.
                    self?.headerView?.setTemperature(weatherResponse.currentWeather.temperature)
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                } catch {
                    print(error)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            manager.startUpdatingLocation()

        case .denied, .restricted:
            locationAlert(alertTitle: "Использование геолокации запрещено", alertMessage: "Перейдите в настройки")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        //reverceGeocode location?
        CLGeocoder().reverseGeocodeLocation(location) { [weak self] placemarks, error in
            //Из первого placemark достает ближайший город. Даже не нужно к API с lat и lon обращаться ради города. 
            guard let placemark = placemarks?.first,
                  let city = placemark.locality
            else { return }
            // Обновляет город, это потребуется для view и для обновления погоды.
            self?.updateCity(city)
            self?.location = (location.coordinate.latitude, location.coordinate.longitude)
        }
    }
}
