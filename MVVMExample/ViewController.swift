//
//  ViewController.swift
//  MVVMExample
//
//  Created by Roman on 08/12/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var models = [Person]()
    
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        configureTableView()
    }
    
    private func configureModels() {
        let names = ["Joe", "Dan", "Jeff", "Roman", "Magda", "Franio", "Julek"]
        models = names.map { Person(name: $0)}
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonFollowingViewCell.self, forCellReuseIdentifier: PersonFollowingViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonFollowingViewCell.reuseIdentifier, for: indexPath) as! PersonFollowingViewCell
        cell.configure(with: PersonFollowingTableViewCellViewModel(with: models[indexPath.row]))
        cell.delegate = self
        return cell
    }
    
    
}

extension ViewController: PersonFollowingViewCellDelegate {
    
    func personFollowingTableViewCell(_ cell: PersonFollowingViewCell, didTapWith viewModel: PersonFollowingTableViewCellViewModel) {
        // here we can for example send data to the back end 
    }
    
    
}

