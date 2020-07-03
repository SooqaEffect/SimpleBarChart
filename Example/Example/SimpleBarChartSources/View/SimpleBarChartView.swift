//
//  SimpleBarChartView.swift
//  FinalTests
//
//  Created by Вячеслав Яшунин on 02.07.2020.
//  Copyright © 2020 Вячеслав Яшунин. All rights reserved.
//

import Foundation
import UIKit

protocol SimpleBarChartViewProtocol: class {
    var mainLayer: CALayer! { get set }
    var scrollView: UIScrollView! { get set }
    var barData: [BarData]! { get set }
}

public class SimpleBarChartView: UIView, SimpleBarChartViewProtocol {
    ///Основной слой, на котором отрисовывается график
    public var mainLayer: CALayer! = CALayer()
    ///UIScrollView, на котором помещен основной слой
    public var scrollView: UIScrollView! = UIScrollView()
    ///Структура с конфигурациями
    private(set) var configuration: BarChartConfiguration!
    
    private var presenter: SimpleBarChartPresenterProtocol!
    
    public var barData: [BarData]! = [] {
        didSet {
            mainLayer.sublayers?.forEach { $0.removeFromSuperlayer() }
            
            let contentWidth = presenter.getContentWidth()
            scrollView.contentSize = CGSize(width: contentWidth, height: self.frame.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            showHorizontalLines()
            
            for (index, entry) in barData.enumerated() {
                setBar(entry: entry, animated: configuration.animated, previousBar: oldValue.safeValue(at: index))
            }
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupScrollViewWithLayer()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupScrollViewWithLayer()
    }
    
    
    //MARK: - Public methods
    public func setData(with configuration: BarChartConfiguration, barData: [BarValueData]) {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        presenter = SimpleBarChartPresenter(view: self, barWidth: configuration.barWidth, spacing: configuration.spacing, barData: barData)
        self.configuration = configuration
        self.scrollView.isScrollEnabled = configuration.isScrollEnabled
        self.presenter.calculateHeight()
        self.barData = presenter.setBarData(maxHeight: self.frame.height)
    }
    
    //MARK: - Private methods
    private func setupScrollViewWithLayer() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 60).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private func showHorizontalLines() {
        self.layer.sublayers?.forEach({
            if $0 is CAShapeLayer {
                $0.removeFromSuperlayer()
            }
        })
        
        self.subviews.forEach({
            if $0 is UILabel {
                $0.removeFromSuperview()
            }
        })
        
        let lines = presenter.getHorizontalLinesToChart(maxHeight: self.frame.height)
        
        
        for line in lines {
            let label = UILabel()
            label.text = "\(line.value)"
            label.textAlignment = .right
            label.font = label.font.withSize(14)
            label.frame = CGRect(x: -5, y: line.startPoint.y - 10, width: 60, height: 20)
            addSubview(label)
            
            mainLayer.addLine(startPoint: line.startPoint, endPoint: line.endPoint, color: line.color, width: line.width, animated: self.configuration.animated)
        }
    }
    
    private func setBar(entry: BarData, animated: Bool, previousBar: BarData?) {
        let color = entry.data.color.cgColor
        let titleColor = entry.data.titleColor.cgColor
        
        
        mainLayer.addRectangle(frame: entry.barFrame, color: color, animated: animated, previousFrame: previousBar?.barFrame)
        
        mainLayer.addText(frame: entry.titleFrame, color: titleColor, fontSize: 14, text: entry.data.title, animated: animated, ailgnmentMode: .center)
        
    }
}
