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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTable()
        self.viewModel.readDataImages {[unowned self] () in
            self.updateTable()
        }
    }
    
    func initTable() {
        self.setupTableView()
        self.setupTableViewBinding()
    }
    
    func updateTable(){
        self.tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupTableViewBinding() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: ImageListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ImageListCell.identifier)
    }
    
    private func reloadCell(indexPath: IndexPath){
        DispatchQueue.main.async(execute: { () -> Void in
               self.tableView.beginUpdates()
               self.tableView.reloadRows(at: [indexPath], with: .fade)
               self.tableView.endUpdates()
        })
    }
    
}

extension ImageListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! ImageListCell
        if !cell.loadindSuccess{
            cell.reloadImage { [unowned self] in
                DispatchQueue.main.async(execute: { () -> Void in
                    self.reloadCell(indexPath: indexPath)
                })
            }
            return
        }
        else {
            self.viewModel.tapOnTheImage(image: self.viewModel.list[indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: ImageListCell.identifier, for: indexPath) as? ImageListCell else {return UITableViewCell()}
        cell.confugure(usecase: self.viewModel.useCaase)
        cell.cellImage = self.viewModel.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell =  cell as? ImageListCell else {return}
        cell.loadImage()
    }

}
