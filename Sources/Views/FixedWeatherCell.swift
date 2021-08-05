//
//  FixedWeatherCell.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 05.08.2021.
//

import UIKit

class FixedWeatherCell: UITableViewCell {

    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [dayLabel, temperatureLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Internal methods
extension FixedWeatherCell {
    func configure(weather: Weather) {
        let dateText = dateFormatter.string(from: weather.day)
        dayLabel.text = dateText
        let temperatureString = String(format: " %.1f °C", weather.temperature)

        let imageName = WeatherSymbolFactory.symbolName(forTemperature: weather.temperature)

        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: imageName)

        let temperatureAttributedString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: temperatureString)
        temperatureAttributedString.append(textString)
        temperatureLabel.attributedText = temperatureAttributedString
    }
}

// MARK: - Private methods
extension FixedWeatherCell {
    private func setupViews() {
        contentView.addSubview(stackView)

        self.backgroundColor = .clear

        dayLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        imageView?.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        temperatureLabel.setContentHuggingPriority(.required, for: .horizontal)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
