//
//  WeatherCell.swift
//  pzdcPogodka
//
//  Created by Nikita Shvad on 29.07.2021.
//

import UIKit

class WeatherCell: UITableViewCell {
    //string, UIView, String{Double%}, Int, Int
    private let dayOfWeekLabel = UILabel()
    private let weatherConditionView = UIView()
    private let highTempLabel = UILabel()
    private let lowTempLabel = UILabel()
    private let chanceOfRainLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK: - Public Function
extension WeatherCell{
    public func configure (dayOfWeek: String, /*weatherConditionView: UIView,*/ chanceOfRain: String, highTemp: String, lowTemp: String){
    dayOfWeekLabel.text = dayOfWeek
    //weatherConditionView = на самом деле STRING
    chanceOfRainLabel.text = chanceOfRain
    highTempLabel.text = highTemp
    lowTempLabel.text = lowTemp
    
    setupViews()
    }
}
//MARK: - Private Function
extension WeatherCell{
    private func setupViews() {
        dayOfWeekLabel.numberOfLines = 1
        dayOfWeekLabel.adjustsFontSizeToFitWidth = true
        dayOfWeekLabel.minimumScaleFactor = 0.1
        dayOfWeekLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        highTempLabel.numberOfLines = 1
        highTempLabel.adjustsFontSizeToFitWidth = true
        highTempLabel.minimumScaleFactor = 0.1
        highTempLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        lowTempLabel.numberOfLines = 1
        lowTempLabel.adjustsFontSizeToFitWidth = true
        lowTempLabel.minimumScaleFactor = 0.1
        lowTempLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        chanceOfRainLabel.numberOfLines = 1
        chanceOfRainLabel.adjustsFontSizeToFitWidth = true
        chanceOfRainLabel.minimumScaleFactor = 0.1
        chanceOfRainLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        weatherConditionView.backgroundColor = .red
        
        dayOfWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionView.translatesAutoresizingMaskIntoConstraints = false
        chanceOfRainLabel.translatesAutoresizingMaskIntoConstraints = false
        highTempLabel.translatesAutoresizingMaskIntoConstraints = false
        lowTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dayOfWeekLabel)
        contentView.addSubview(weatherConditionView)
        contentView.addSubview(chanceOfRainLabel)
        contentView.addSubview(highTempLabel)
        contentView.addSubview(lowTempLabel)
        
        setupConstraints()
        
    }
}
//MARK: - Constraints
extension WeatherCell{
    private func setupConstraints (){
        let dayOfWeekLabelConstraints = [
            NSLayoutConstraint(item: dayOfWeekLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dayOfWeekLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dayOfWeekLabel, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: dayOfWeekLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 0.5, constant: 0)
        ]
        NSLayoutConstraint.activate(dayOfWeekLabelConstraints)
        
        let weatherConditionConstraints = [
            NSLayoutConstraint(item: weatherConditionView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherConditionView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherConditionView, attribute: .left, relatedBy: .equal, toItem: dayOfWeekLabel, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: weatherConditionView, attribute: .right, relatedBy: .equal, toItem: contentMode, attribute: .right, multiplier: 0.6, constant: 0)
        ]
        NSLayoutConstraint.activate(weatherConditionConstraints)
        
        let chanceOfRainLabelConstraints = [
            NSLayoutConstraint(item: chanceOfRainLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: chanceOfRainLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: chanceOfRainLabel, attribute: .left, relatedBy: .equal, toItem: weatherConditionView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: chanceOfRainLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 0.7, constant: 0)
        ]
        NSLayoutConstraint.activate(chanceOfRainLabelConstraints)
        
        let highTempLabelConstraints = [
            NSLayoutConstraint(item: highTempLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: highTempLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: highTempLabel, attribute: .left, relatedBy: .equal, toItem: chanceOfRainLabel, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: highTempLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 0.8, constant: 0)
        ]
        NSLayoutConstraint.activate(highTempLabelConstraints)
        
        let lowTempLabelConstraints = [
            NSLayoutConstraint(item: lowTempLabel, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: lowTempLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: lowTempLabel, attribute: .left, relatedBy: .equal, toItem: highTempLabel, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: lowTempLabel, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 0.9, constant: 0)
        ]
        NSLayoutConstraint.activate(lowTempLabelConstraints)
        
        
    }
}
