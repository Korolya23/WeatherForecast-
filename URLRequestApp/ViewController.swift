//
//  ViewController.swift
//  URLRequestApp
//
//  Created by Artem on 25.02.25.
//

import UIKit

class ViewController: UIViewController {
    let networkApi = NetworkApi()
    
    let temratureLabel = UILabel()
    let nameCity = UILabel()
    let searchTextField = UITextField()
    let weatherIcon = UIImageView()
    let dateUpdate = UILabel()
    let weatherKm = UILabel()

    
    var tempDays: [UILabel] = []
    var dateDays: [UILabel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBackground()
        searchCity(city: "Minsk")
        getImage()
    }
    
    func searchCity(city: String) {
        networkApi.getWeather(city: city) { [weak self] temp in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if let temperature = temp {
                    self.temratureLabel.text = "\(temperature.current.temp_c)°C"
                    self.nameCity.text = city
                    self.dateUpdate.text = "\(temperature.location.localtime)"
                    self.weatherKm.text = "\(temperature.current.wind_kph) km/h, \(temperature.current.humidity)%"
                    
                    for (index, forecast) in temperature.forecast.forecastday.enumerated() {
                        if index < self.tempDays.count {
                            self.tempDays[index].text = "\(forecast.day.avgtemp_c)°C"
                            self.dateDays[index].text = "\(forecast.date)"
                        }
                    }
                } else {
                    self.temratureLabel.text = "Error"
                }
            }
        }
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        weatherIcon.contentMode = .scaleAspectFit
        weatherIcon.frame = CGRect(x: 20, y: 180, width: view.frame.width - 40, height: 140)
        view.addSubview(weatherIcon)

        let placeholderColor: UIColor = .systemGray2
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Enter city name...", attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        searchTextField.borderStyle = .roundedRect
        searchTextField.backgroundColor = .clear
        searchTextField.textColor = .white
        searchTextField.font = .systemFont(ofSize: 20)
        searchTextField.delegate = self
        searchTextField.frame = CGRect(x: 20, y: 80, width: view.frame.width - 40, height: 40)
        searchTextField.returnKeyType = .search
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.cornerRadius = 20
        searchTextField.layer.masksToBounds = true
        let customColor = UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 1.0)
        searchTextField.layer.borderColor = customColor.cgColor
        view.addSubview(searchTextField)
        
        nameCity.font = .systemFont(ofSize: 36, weight: .medium)
        nameCity.frame = CGRect(x: 0, y: 324, width: view.frame.width, height: 100)
        nameCity.textAlignment = .center
        nameCity.textColor = .white
        view.addSubview(nameCity)
        
        temratureLabel.font = .systemFont(ofSize: 80, weight: .bold)
        temratureLabel.frame = CGRect(x: 0, y: 420, width: view.frame.width, height: 100)
        temratureLabel.textAlignment = .center
        temratureLabel.textColor = .white
        view.addSubview(temratureLabel)
        
        dateUpdate.font = .systemFont(ofSize: 16, weight: .medium)
        dateUpdate.frame = CGRect(x: 0, y: 350, width: view.frame.width, height: 100)
        dateUpdate.textAlignment = .center
        dateUpdate.textColor = .white
        view.addSubview(dateUpdate)
        
        weatherKm.font = .systemFont(ofSize: 16, weight: .medium)
        weatherKm.frame = CGRect(x: 0, y: 466, width: view.frame.width, height: 100)
        weatherKm.textAlignment = .center
        weatherKm.textColor = .white
        view.addSubview(weatherKm)
        
        for i in 0..<7 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 28, weight: .bold)
            label.frame = CGRect(x: 32 + (i * 124), y: 620, width: Int(view.frame.width) - 40, height: 30)
            label.textAlignment = .left
            label.textColor = .white
            tempDays.append(label)
            view.addSubview(label)
        }
        
        for i in 0..<7 {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .bold)
            label.frame = CGRect(x: 28 + (i * 124), y: 588, width: Int(view.frame.width) - 40, height: 30)
            label.textAlignment = .left
            label.textColor = .white
            dateDays.append(label)
            view.addSubview(label)
        }
        
    }
    
    private func setupBackground() {
           // Создаем градиентный слой
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = view.bounds
           
           // Задаем цвета для градиента (8 цветов)
           gradientLayer.colors = [
               UIColor(red: 0.1, green: 0.1, blue: 0.8, alpha: 1.0).cgColor, // Синий
               UIColor(red: 0.2, green: 0.2, blue: 0.9, alpha: 1.0).cgColor, // Голубой
               UIColor(red: 0.3, green: 0.3, blue: 1.0, alpha: 1.0).cgColor, // Светло-голубой
               UIColor(red: 0.4, green: 0.4, blue: 1.0, alpha: 1.0).cgColor, // Бирюзовый
               UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1.0).cgColor, // Светло-бирюзовый
               UIColor(red: 0.6, green: 0.6, blue: 1.0, alpha: 1.0).cgColor, // Бледно-голубой
               UIColor(red: 0.7, green: 0.7, blue: 1.0, alpha: 1.0).cgColor, // Почти белый
               UIColor(red: 0.8, green: 0.8, blue: 1.0, alpha: 1.0).cgColor  // Белый
           ]
           
           // Направление градиента (сверху вниз)
           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
           
           // Добавляем градиентный слой на задний план
           view.layer.insertSublayer(gradientLayer, at: 0)
       }
    
    func getImage() {
        if let image = UIImage(named: "weather") {
            weatherIcon.image = image
        } else {
            print("Error loading image")
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            // Скрываем клавиатуру при нажатии на Return
            textField.resignFirstResponder()
            
            // Получаем текст из поисковой строки
            if let city = textField.text, !city.isEmpty {
                searchCity(city: city) // Запрашиваем погоду для введенного города
            }
        
        textField.text = ""
            
            return true
        }
}
