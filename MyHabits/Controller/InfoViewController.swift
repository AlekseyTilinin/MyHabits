//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Aleksey on 11.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

        private lazy var infoTitle: UILabel = {
            let label = UILabel()
            label.text = informationTitle
            label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        private lazy var infoText: UILabel = {
            let label = UILabel()
            label.text = informatiosText
            label.font = UIFont.systemFont(ofSize: 17)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .systemBackground
            navBarCustomization()
            addConstraints()
        }
    
        func addConstraints() {
            view.addSubview(scrollView)
            scrollView.addSubview(infoTitle)
            scrollView.addSubview(infoText)
    
            NSLayoutConstraint.activate([
    
                scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    
                infoTitle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 22),
                infoTitle.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
    
                infoText.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 62),
                infoText.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16),
                infoText.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
                infoText.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16)
            ])
        }
    
        func navBarCustomization() {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .systemBackground
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            self.navigationItem.title = "Информация"
        }
}
