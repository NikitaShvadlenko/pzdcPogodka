//
//  WeatherHeaderView.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 05.08.2021.
//

import UIKit

class WeatherHeaderView: UITableViewHeaderFooterView {

    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.text = "—"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь могла быть ваша реклама"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "— °C"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Internal methods
extension WeatherHeaderView {
    func setCity(_ city: String) {
        cityLabel.text = city
    }

    func setTemperature(_ temperature: Double) {
        temperatureLabel.text = String(format: "%.1f °C", temperature)
    }
}

// MARK: - Private methods
extension WeatherHeaderView {
    private func setupViews() {
        tintColor = .gray

        contentView.addSubview(cityLabel)
        contentView.addSubview(weatherLabel)
        contentView.addSubview(temperatureLabel)

        let headerViewConstraints = [
            cityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cityLabel.heightAnchor.constraint(equalToConstant: 40),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            weatherLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 2),
            weatherLabel.heightAnchor.constraint(equalToConstant: 15),
            weatherLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            weatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            temperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 10),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 30),
            temperatureLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            temperatureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
        ]

        NSLayoutConstraint.activate(headerViewConstraints)
    }
}
