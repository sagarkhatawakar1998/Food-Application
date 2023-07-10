//
//  OrdersViewController.swift
//  Food Delivery App
//
//  Created by IND040101154 on 07/07/23.
//

import UIKit



// section in tableview
enum Orders {
    case profile
    case status
    case items
}



class OrdersViewController: UIViewController {
    var orderData: [OrderDetailItem] = []
    var sectionArray: [Orders] = [ .profile, .status, .items]

    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.register(UINib(nibName: OrderItemTableViewCell.identifier,
                                     bundle: nil),
                               forCellReuseIdentifier: OrderItemTableViewCell.identifier)
            tableview.register(UINib(nibName: OrderProfileTableViewCell.identifier,
                                     bundle: nil),
                               forCellReuseIdentifier: OrderProfileTableViewCell.identifier)
            tableview.register(UINib(nibName: OrderStatusTableViewCell.identifier,
                                     bundle: nil),
                               forCellReuseIdentifier: OrderStatusTableViewCell.identifier)
            tableview.estimatedRowHeight = 44
            tableview.rowHeight = UITableView.automaticDimension
            tableview.translatesAutoresizingMaskIntoConstraints = false

            tableview.separatorStyle = .none
            if #available(iOS 15.0, *) {
                tableview.sectionHeaderTopPadding = 8
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.delegate = self
        self.tableview.dataSource = self
        setUpNavBar()
        updateData()
        loadTableHeaderview()
    }
    
    // implement table headerview
    private func loadTableHeaderview() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableview.frame.width, height: tableview.frame.height / 3))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height))
        imageView.image = UIImage(named: "_20210615_172740")
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleToFill
        tableview.tableHeaderView = headerView

    }
    
    // pop to view contorller when tapped on button
    @IBAction func didTapdone(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
   
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionArray[section] {
        case .profile, .status : return 1
        case .items   : return orderData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sectionArray [indexPath.section]
        if section == .profile {
            let cell =  tableView.dequeueReusableCell(withIdentifier: OrderProfileTableViewCell.identifier, for: indexPath) as? OrderProfileTableViewCell
            cell?.setupData()
            return cell ?? UITableViewCell()
        }
        else if section == .status {
            let cell =  tableView.dequeueReusableCell(withIdentifier: OrderStatusTableViewCell.identifier, for: indexPath) as? OrderStatusTableViewCell
            return cell ?? UITableViewCell()
        }
        else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: OrderItemTableViewCell.identifier, for: indexPath) as? OrderItemTableViewCell
            cell?.setUpWith(with: orderData[indexPath.row])
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel(frame: CGRect(x: 16, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 10))
        label.textColor = foodlyPurple
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        switch sectionArray[section] {
        case .profile:
            label.text = "User Profile"
        case .items:
            label.text = "Ordered Items"
        case .status:
            label.text = "Order Status"
        }
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}


// MARK: - Private function
extension OrdersViewController {
    
    // set up the navigation bar
    private func setUpNavBar() {
        self.title = "Order Details"
        let barBurtton = UIBarButtonItem(title: "₹1000", style: .plain, target: nil, action: nil)
        barBurtton.tintColor = UIColor.red
        navigationItem.setRightBarButtonItems([barBurtton], animated: true)
    }
    
    private func updateData() {
        let data = [
           OrderDetailItem(dish: Dishes(id: "item3",
                                        name: "Nachos",
                                        description: "The first, original plate of nachos consisting of tortilla chips, melted chips, and jalapeños was made for a group of military officers' wives in 1943 in Piedras Negras, Mexico. The ladies of the US Army Air Force base went over to a restaurant in the city, called the Victory Club.",
                                        image: "https://cdn.tasteatlas.com//images/dishes/a29fe2d3d9c54547a9e49c49f5cf22cd.jpg?width=660&height=420", resturnatNames: "Hog Heaven",
                                        calories: 423), noOfitems: 2),
           OrderDetailItem(dish:
                            Dishes(id: "item4",
                                   name: "Quesadilla",
                                   
                                   description: "Quesadilla is a simple Mexican snack consisting of a flour or corn tortilla filled with cheese that melts well. It is commonly folded in half and consumed. A quesadilla can also have some other ingredients on the inside such as meats, beans, or potatoes, but cheese is always mandatory (with the exception of Mexico City, where cheese in a quesadilla is often an afterthought).",
                                   image: "https://cdn.tasteatlas.com//images/dishes/cde29cfce09c43b0acc43e19a77b845b.jpg?width=660&height=420", resturnatNames: "Rustic Eats",
                                   calories: 827), noOfitems: 1),
           OrderDetailItem(dish: Dishes(id: "item3",
                                        name: "Nachos",
                                        description: "The first, original plate of nachos consisting of tortilla chips, melted chips, and jalapeños was made for a group of military officers' wives in 1943 in Piedras Negras, Mexico. The ladies of the US Army Air Force base went over to a restaurant in the city, called the Victory Club.",
                                        image: "https://cdn.tasteatlas.com//images/dishes/a29fe2d3d9c54547a9e49c49f5cf22cd.jpg?width=660&height=420", resturnatNames: "Hog Heaven",
                                        calories: 423), noOfitems: 2),
           OrderDetailItem(dish:
                            Dishes(id: "item4",
                                   name: "Quesadilla",
                                   
                                   description: "Quesadilla is a simple Mexican snack consisting of a flour or corn tortilla filled with cheese that melts well. It is commonly folded in half and consumed. A quesadilla can also have some other ingredients on the inside such as meats, beans, or potatoes, but cheese is always mandatory (with the exception of Mexico City, where cheese in a quesadilla is often an afterthought).",
                                   image: "https://cdn.tasteatlas.com//images/dishes/cde29cfce09c43b0acc43e19a77b845b.jpg?width=660&height=420", resturnatNames: "Rustic Eats",
                                   calories: 827), noOfitems: 1)
        ]
        
        self.orderData = data
        self.tableview.reloadData()
    }
}
