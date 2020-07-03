//
//  ViewController.swift
//  Example
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chartView: SimpleBarChartView!
    
    let data = [BarValueData(title: "Пт", color: #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 4787), BarValueData(title: "Сб", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2000), BarValueData(title: "Вс", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 7899), BarValueData(title: "Пн", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 1058), BarValueData(title: "Вт", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2388), BarValueData(title: "Ср", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2585), BarValueData(title: "Чт", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 4075)]
    
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        button.setTitle("Go to 2VC", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView = SimpleBarChartView(frame: .zero)
        view.addSubview(chartView)
        view.addSubview(button)
        
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.heightAnchor.constraint(equalToConstant: self.view.frame.height / 3).isActive = true
        chartView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        let spacing: CGFloat = 20.0
        let width: CGFloat = CGFloat(self.view.frame.width / 9.5) - (spacing)
        
        let configuration = BarChartConfiguration(animated: true, barWidth: width, spacing: spacing, isScrollEnabled: false)
        
        Utils.emptyDataCount = 7
        
        
        chartView.setData(with: configuration, barData: Utils.setEmptyData())
        chartView.setData(with: configuration, barData: data)
    }
    
    
    @objc func onButtonClick() {
        let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: SecondViewController.self)) as! SecondViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
    }
    
}


