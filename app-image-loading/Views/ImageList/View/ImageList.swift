//
//  ImageList.swift
//  app-image-loading
//
//  Created by maxim mironov on 17.01.2021.
//  Copyright © 2021 maxim mironov. All rights reserved.
//

import UIKit
class ImageListViewController: UIViewController {
    unowned var viewModel: ImageListViewModel!
    let tableView = UITableView()
    var myArray = [CellWithImageModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
        self.viewModel.readDataImages { [unowned self] (data: [CellWithImageModel]) in
            self.myArray = data
            self.tableView.reloadData()
        }
        
    }
    
    func initTable() {
        self.setupTableView()
        self.setupTableViewBinding()
    }
    
    private func setupTableView() {
           view.addSubview(tableView)
           tableView.translatesAutoresizingMaskIntoConstraints = false
           tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
           tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
           tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
           tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    private func setupTableViewBinding() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: ImageListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ImageListCell.identifier)
    }
    
}
extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ImageListCell
        if !cell.isLoaded {
            return
        }
        if !cell.succes{
            cell.reloadImage()
            return
        }
       self.viewModel.tapOnTheImage(image: myArray[indexPath.row])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: ImageListCell.identifier, for: indexPath) as? ImageListCell else {return UITableViewCell()}
        cell.confugure(usecase: self.viewModel.useCaase)
        cell.cellImage = myArray[indexPath.row]
        return cell
    }

}
