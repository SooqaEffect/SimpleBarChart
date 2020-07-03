//
//  SecondViewController.swift
//  Example
//
//  Created by Вячеслав Яшунин on 03.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import UIKit

protocol SecondViewProtocol: class {
    var presenter: SecondViewPresenterProtocol! { get set }
    func showDays()
    
    func onError(errorString: String)
    func onSuccess(data: [BarValueData])
}

class SecondViewController: UIViewController, SecondViewProtocol {
    func onError(errorString: String) {
        
    }
    
    @IBOutlet weak var chartView: SimpleBarChartView!
    
    var presenter: SecondViewPresenterProtocol!
    
    let data = [BarValueData(title: "Пт", color: #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 4787), BarValueData(title: "Сб", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2000), BarValueData(title: "Вс", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 7899), BarValueData(title: "Пн", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 1058), BarValueData(title: "Вт", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2388), BarValueData(title: "Ср", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 2585), BarValueData(title: "Чт", color:  #colorLiteral(red: 0.3272460699, green: 0.6936482191, blue: 0.3788549304, alpha: 1), titleColor: .black, value: 4075)]

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SecondViewPresenter(with: self)
        showDays()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chartView.setData(with: getConfgirutaion(), barData: Utils.setEmptyData())
    }
    
    
    func showDays() {
        presenter.getDataFromLastWeak()
    }
    
    func onSuccess(data: [BarValueData]) {
        chartView.setData(with: getConfgirutaion(), barData: data)
    }
    
    private func getConfgirutaion() -> BarChartConfiguration {
        let spacing: CGFloat = 20.0
        let width: CGFloat = CGFloat(self.view.frame.width / 9.5) - (spacing)
        return BarChartConfiguration(animated: true, barWidth: width, spacing: spacing, isScrollEnabled: false)
    }
    
    @IBAction func onDismissClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

