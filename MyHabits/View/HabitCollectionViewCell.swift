//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Aleksey on 26.10.2022.
//

import Foundation
import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private lazy var habitNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Выпить стакан воды"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var habitTimeText : UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 7:30"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray2
        return label
    }()
    
    private lazy var habitCountLabel : UILabel = {
        let label = UILabel()
        label.text = "Счетчик: 0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var statusButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 19
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"check")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.isHidden = true
        return image
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = .white
        
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(habitTimeText)
        contentView.addSubview(habitCountLabel)
        contentView.addSubview(statusButton)
        contentView.addSubview(checkImage)
        
        NSLayoutConstraint.activate([
            habitNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            habitNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            habitNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -103),
            
            habitTimeText.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            habitTimeText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            habitCountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 92),
            habitCountLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            
            statusButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 46),
            statusButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25),
            statusButton.heightAnchor.constraint(equalToConstant: 38),
            statusButton.widthAnchor.constraint(equalToConstant: 38),
            
            checkImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 57),
            checkImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
            checkImage.heightAnchor.constraint(equalToConstant: 16),
            checkImage.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        
    }
    
    @objc func clickButton() {
        let index = habitNameLabel.tag
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday == false {
            statusButton.backgroundColor = UIColor(cgColor: statusButton.layer.borderColor!)
            HabitsStore.shared.track(HabitsStore.shared.habits[index])
            habitCountLabel.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
            checkImage.isHidden = false
            
            NotificationCenter.default.post(name: Notification.Name("reloadData"), object: nil)
        }
    }
    
    func setup(index : Int) {
        
        habitNameLabel.tag = index
        statusButton.layer.borderColor = HabitsStore.shared.habits[index].color.cgColor
        habitNameLabel.text = HabitsStore.shared.habits[index].name
        habitNameLabel.textColor = HabitsStore.shared.habits[index].color
        habitTimeText.text = "Каждый день в \(HabitsStore.shared.habits[index].dateString)"
        habitCountLabel.text = "Счетчик: \(HabitsStore.shared.habits[index].trackDates.count)"
        
        if HabitsStore.shared.habits[index].isAlreadyTakenToday {
            statusButton.backgroundColor = UIColor(cgColor: HabitsStore.shared.habits[index].color.cgColor)
            checkImage.isHidden = false
        } else {
            statusButton.backgroundColor = nil
            checkImage.isHidden = true
        }
    }
}
