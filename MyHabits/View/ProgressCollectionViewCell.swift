//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Aleksey on 13.10.2022.
//

import Foundation
import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var progressTitle : UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressLevel : UILabel = {
        let label = UILabel()
        label.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressLine : UIProgressView = {
        let line = UIProgressView()
        line.progress = HabitsStore.shared.todayProgress
        line.tintColor = habitColorPurple
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        contentView.addSubview(progressTitle)
        contentView.addSubview(progressLevel)
        contentView.addSubview(progressLine)
        
        NSLayoutConstraint.activate([
            progressTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            
            progressLevel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            progressLevel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            
            progressLine.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 10),
            progressLine.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 12),
            progressLine.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -12),
            progressLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        progressLevel.text = "\(Int(HabitsStore.shared.todayProgress*100))%"
        progressLine.progress = HabitsStore.shared.todayProgress
    }
}
