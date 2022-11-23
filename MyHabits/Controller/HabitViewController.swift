//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Aleksey on 12.10.2022.
//

import Foundation
import UIKit


var callPlace = ""
var habitIndex = Int()
var mark : Int = 0

class HabitViewController: UIViewController {
    
    private lazy var habitNameTitle: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitName : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var habitColorTitle : UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitColorPickerButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 255/255, green: 159/255, blue: 79/255, alpha: 1)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(showColorPicker) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var habitTimeTitle : UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var habitTimeText : UILabel = {
        let label = UILabel()
        label.text = "Каждый день в "
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var habitSelectedTime : UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = habitColorPurple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(didSelect), for: .valueChanged)
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private lazy var habitDeleteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(deleteHabit) , for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку ?", preferredStyle: .alert)
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        navBarCustomization()
        addConstraints()
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Удалить", style: .default, handler: { _ in
            HabitsStore.shared.habits.remove(at: habitIndex)
            self.dismiss(animated: true)
            mark = 1
        }))
    }
    
    func navBarCustomization() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let dismissButton = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(hideModal))
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.leftBarButtonItem?.tintColor = habitColorPurple
        
        if  callPlace == "fromNewHabit" {
            let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveHabbit))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 17, weight: .semibold), .foregroundColor : habitColorPurple], for: .normal)
            
            self.navigationItem.title = "Создать"
        } else {
            let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveEditHabbit))
            navigationItem.rightBarButtonItem = saveButton
            navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 17, weight: .semibold), .foregroundColor : habitColorPurple], for: .normal)
            
            self.navigationItem.title = "Править"
        }
    }
    
    private func addConstraints() {
        
        view.addSubview(habitNameTitle)
        view.addSubview(habitName)
        view.addSubview(habitColorTitle)
        view.addSubview(habitColorPickerButton)
        view.addSubview(habitTimeTitle)
        view.addSubview(habitTimeText)
        view.addSubview(habitSelectedTime)
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            
            self.habitNameTitle.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 21),
            self.habitNameTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.habitName.topAnchor.constraint(equalTo: self.habitNameTitle.bottomAnchor, constant: 7),
            self.habitName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.habitColorTitle.topAnchor.constraint(equalTo: self.habitName.bottomAnchor, constant: 15),
            self.habitColorTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.habitColorPickerButton.topAnchor.constraint(equalTo: self.habitColorTitle.bottomAnchor, constant: 7),
            self.habitColorPickerButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.habitColorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            self.habitColorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            
            self.habitTimeTitle.topAnchor.constraint(equalTo: self.habitColorPickerButton.bottomAnchor, constant: 15),
            self.habitTimeTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.habitTimeText.topAnchor.constraint(equalTo: self.habitTimeTitle.bottomAnchor, constant: 7),
            self.habitTimeText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            
            self.habitSelectedTime.topAnchor.constraint(equalTo: self.habitTimeTitle.bottomAnchor, constant: 7),
            self.habitSelectedTime.leftAnchor.constraint(equalTo: self.habitTimeText.rightAnchor),
            
            self.datePicker.topAnchor.constraint(equalTo: self.habitTimeText.bottomAnchor, constant: 15),
            self.datePicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.datePicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        if callPlace == "fromDetail" {
            self.navigationItem.title = "Править"
            habitName.text = HabitsStore.shared.habits[habitIndex].name
            habitColorPickerButton.backgroundColor = HabitsStore.shared.habits[habitIndex].color
            habitSelectedTime.text = HabitsStore.shared.habits[habitIndex].dateString
            datePicker.date = HabitsStore.shared.habits[habitIndex].date
            
            view.addSubview(habitDeleteButton)
            
            NSLayoutConstraint.activate([
                habitDeleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -18),
                habitDeleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                habitDeleteButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    @objc func hideModal() {
        dismiss(animated: true)
    }
    
    @objc func saveHabbit() {
        let newHabbit = Habit(
            name: habitName.text ?? " ",
            date: datePicker.date,
            color: habitColorPickerButton.backgroundColor ?? .white)
        
        let store = HabitsStore.shared
        store.habits.append(newHabbit)
        
        dismiss(animated: true)
    }
    
    @objc func saveEditHabbit() {
        HabitsStore.shared.habits[habitIndex].name = habitName.text ?? ""
        HabitsStore.shared.habits[habitIndex].color = habitColorPickerButton.backgroundColor ?? .white
        HabitsStore.shared.habits[habitIndex].date = datePicker.date
        HabitsStore.shared.save()
        
        dismiss(animated: true)
        mark = 1
        
    }
    
    @objc func showColorPicker() {
        let color = UIColorPickerViewController()
        color.supportsAlpha = false
        color.delegate = self
        color.selectedColor = habitColorPickerButton.backgroundColor!
        present(color, animated: true)
    }
    
    @objc func didSelect() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.string(from: datePicker.date)
        
        habitSelectedTime.text = "\(dateFormatter.string(from: datePicker.date))"
    }
    
    @objc func deleteHabit() {
        alertController.message = "Вы хотите удалить привычку \(habitName.text ?? "")?"
        self.present(alertController, animated: true, completion: nil)
    }
}

extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        habitColorPickerButton.backgroundColor = viewController.selectedColor
    }
}

