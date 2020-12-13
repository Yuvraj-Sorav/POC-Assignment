//
//  DashboardViewController.swift
//  Proofofconcept
//
//  Created by Yuvraj Sorav on 13/12/20.
//

import UIKit

class DashboardViewController : UIViewController {
    
    let dashboardReuseIdentifier = "DashboardCellIdentifier"
    let tableview = UITableView()
    var dashboardViewModel : DashboardViewModel?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = .black
        return refreshControl
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureTableView()
        setUpInitials()
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        setUpInitials()
    }
    
    private func configureTableView() {
        tableview.accessibilityIdentifier = AccessibilityIdentifier.dashboardTableViewIdentifier
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 80.0
        tableview.register(DashboardCell.self, forCellReuseIdentifier: dashboardReuseIdentifier)
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navigationController?.navigationBar.prefersLargeTitles = true
        tableview.refreshControl = refreshControl
        
    }
    
    private func setUpInitials() {
        if Reachability.isConnectedToNetwork() {
            DashboardViewModel.getDashboardData { (dashBoardViewMod, errorMsg) in
                if errorMsg == nil {
                    self.dashboardViewModel = dashBoardViewMod
                    DispatchQueue.main.async {
                        self.title = self.dashboardViewModel?.titleStr
                        self.refreshControl.endRefreshing()
                        self.tableview.reloadData()
                    }
                }else {
                    self.view.displayToast(errorMsg ?? StaticErrorMessage.somethingWentWrongMessage)
                }
            }
        }else {
            self.view.displayToast(StaticErrorMessage.noInternetMessage)
        }
    }
}

extension DashboardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dashboardViewModel?.rowsArr?.isEmpty ?? false {
            tableView.setNoDataMessage()
        }else {
            tableView.restoreData()
        }
        return dashboardViewModel?.rowsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dashBoardCell = tableview.dequeueReusableCell(withIdentifier: dashboardReuseIdentifier, for: indexPath) as? DashboardCell else {
            return UITableViewCell()
        }
        if let rows = dashboardViewModel?.rowsArr {
            dashBoardCell.setUpCell(rows, indexPath)
        }
        return dashBoardCell
    }
    
}


