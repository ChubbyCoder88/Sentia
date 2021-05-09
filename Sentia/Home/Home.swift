//
//  Home.swift
//  Sentia
//
//  Created by Matthew on 7/5/21.
//

import UIKit
import Combine
import Foundation

class Home: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIImageView!
    var clean = CleanData()
    var id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let nib = UINib(nibName: "HomeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        dataApiCall()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForeground), name:  UIApplication.willEnterForegroundNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name:  UIApplication.didEnterBackgroundNotification, object: nil)
    }
    @objc func appMovedToForeground() {
        AppIsIn.Foreground = true
    }
    @objc func appMovedToBackground() {
        AppIsIn.Foreground = false
    }

    private var usersSubscriper: AnyCancellable?
            var listData = [ListViewModel]()
     func dataApiCall() {
        usersSubscriper = DataManagerList().usersPublisher
            .sink(receiveCompletion: { [weak self] finished in
                switch finished {
                case .failure(_): Alert.show(title: "There was an issue", message: "Please try later", vc: self ?? Home())
                case .finished: print("finished")
                }
             }, receiveValue: { [weak self] (data) in
                self?.refactorData(data: data)
             })
    }
    func refactorData(data: ListModel) {
        do {
            try clean.refactorAndInsertIntoViewModel(data: data, completion: { [weak self] (result) in
            switch result {
                case .failure(let error): print("error", error)
                case .success(let data1): self?.listData = data1;
                    self?.loadingIndicator.isHidden = true
                    DispatchQueue.main.async {
                        self?.tableView.reloadData();
                        self?.tableView.tableFooterView = UIView()
                    }
              }})
        } catch { Alert.show(title: "There was an issue", message: "Please try later", vc: self) }
    }
}

extension Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = listData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeCell
        cell.data = data
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var input = listData[indexPath.row]
        id = "ID: \(input.id)"
        performSegue(withIdentifier: "detail", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let nextView = segue.destination as! DetailVC
            nextView.id = id
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 470
    }
}


