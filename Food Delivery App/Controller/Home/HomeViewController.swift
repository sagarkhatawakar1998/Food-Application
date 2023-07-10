
import UIKit

class HomeViewController: UIViewController {
    
    var dishesData: [Dishes] = []
    
    @IBOutlet weak var tableview: UITableView! {
        didSet {
            tableview.register(UINib(nibName: RestaurantsTableViewCell.identifier,
                                     bundle: nil),
                               forCellReuseIdentifier: RestaurantsTableViewCell.identifier)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForUserLogin()
        setdataForTableView()
        setUpNavBar()
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantsTableViewCell.identifier, for: indexPath) as? RestaurantsTableViewCell
        cell?.setup(with: dishesData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let homeDetailVc = self.storyboard?.instantiateViewController(identifier: "HomeDetailViewController") as? HomeDetailViewController, let nav = self.navigationController  else {
            return
        }
        homeDetailVc.dishe = dishesData[indexPath.row]
        nav.pushViewController(homeDetailVc, animated: true)
    }
    
    
}


// MARK: - Private functions
extension HomeViewController {
    // check user status for login
    private func checkForUserLogin() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "personname")
        if email == nil, username == nil {
            guard let signupVC = self.storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController, let nav = self.navigationController  else {
                return
            }
            nav.setNavigationBarHidden(true, animated: true)
            nav.modalPresentationStyle = .fullScreen
            nav.pushViewController(signupVC, animated: true)
        }
    }
    
    // set up the navigation bar
    private func setUpNavBar() {
        self.title = "Dishes"
        let barBurtton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(didTapOrders))
        barBurtton.tintColor = UIColor.red
        
        let logoutbarBurtton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapLogout))
        logoutbarBurtton.tintColor = UIColor.red
        navigationItem.setRightBarButtonItems([barBurtton, logoutbarBurtton], animated: true)
    }
    
    // logout
    @objc func didTapLogout() {
        handlelogout()
    }
    
    // navigate to orders detail
    @objc func didTapOrders() {
//        guard let homeDetailVc = self.storyboard?.instantiateViewController(identifier: "OrderDetailViewControllers") as? OrderDetailViewController, let nav = self.navigationController  else {
//            return
//        }
        guard let homeDetailVc = self.storyboard?.instantiateViewController(identifier: "OrdersViewController") as? OrdersViewController, let nav = self.navigationController  else {
            return
        }
        nav.pushViewController(homeDetailVc, animated: true)

    }
    
    // implement the logout
    private func handlelogout() {
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "personname")
        UserDefaults.standard.removeObject(forKey: "userimage")
        let email = UserDefaults.standard.string(forKey: "email")
        let username = UserDefaults.standard.string(forKey: "personname")
        
        guard  email == nil, username == nil, let signupVC = self.storyboard?.instantiateViewController(identifier: "LoginTableViewController") as? LoginTableViewController, let nav = self.navigationController  else {
            return
        }
        nav.pushViewController(signupVC, animated: true)
    }
}


extension HomeViewController {
     private func  setdataForTableView() {
         let dishesData: [Dishes] = [
             Dishes(id: "item12", name: "Pizza Napoletana", description: "The dough is comprised of wheat flour, yeast, salt, and water and is left to rise for up to 24 hours. It's shaped by hand into a flat, round disk, about 3 millimeters thick. After that, it's topped with ingredients and baked for 90 seconds in a blisteringly hot wood-burning oven. The result is a soft, elastic heart with a tall, fluffy crust called the cornicione in Italian. You can find this variety at your local Eataly's La Pizza & La Pasta restaurant.", image: "https://upload.wikimedia.org/wikipedia/commons/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg", resturnatNames: "Muddy Creek Tavern", calories: 120),
             
             Dishes(id: "pop2", name: "Cassava Flakes", description: "Garri, otherwise known as Cassava Flakes, is one of the main sources of carbohydrates and a popular staple food in Nigeria. It is a local delicacy eaten across Nigeria, usually mixed with sugar, milk, etc and eaten however you desire.", image: "https://p3y6v9e6.stackpathcdn.com/wp-content/uploads/zikoko/2020/03/D1sPmD5XQAA7Hjh.jpg", resturnatNames: "Countryside Cravings", calories: 102),
             
             Dishes(id: "pop4", name: "Pasta Carbonara", description: "The carbonara we know today is prepared by simply tossing spaghetti with guanciale (cured pork jowl), egg yolks, and Pecorino Romano cheese. Despite its simplicity, this dish remains one of Rome's favorites, equally popular throughout the country.", image: "https://cdn.tasteatlas.com/images/dishes/990d2b4155d248ff8838ca8350be1d78.jpg?w=905&h=510", resturnatNames: "Rustic Eats", calories: 302),
             
             Dishes(id: "pop5", name: "Kasha", description: "The fundamental dish of Russian cuisine is known as kasha, a porridge that has represented an essential Russian meal for centuries. Russian kasha refers to various dishes which are created with cereals, most commonly rice, wheat, or millet, and pseudocereals like buckwheat and quinoa.", image: "https://cdn.tasteatlas.com//Images/Dishes/ee60c7c639314b76918e97a37e547531.jpg?width=660&height=420", resturnatNames: "Hog Heaven", calories: 599),
             
             Dishes(id: "pop3", name: "Grilled Cheese", description: "A toasted sandwich, grilled cheese sandwich, cheese toastie, or grilled cheese is a hot sandwich made with one or more varieties of cheese on bread.", image: "https://hips.hearstapps.com/hmg-prod/images/grilled-cheese-horizontal-jpg-1522266016.jpg", resturnatNames: "Country Style!", calories: 1022),
             
             
             
             Dishes(id: "item1",
                    name: "Pommes frites",
                    description: "There are not many dishes in the world that have risen to the popularity of pommes frites. Originally invented in Belgium, this simple dish is made out of potatoes that are cut into lengthwise strips and deep-fried in hot oil. Although there is some rivalry between France and Belgium concerning the exact origin of pommes frites, the fact is that there is no nation in the world which celebrates and enjoys this dish more than the Belgians.",
                    image: "https://cdn.tasteatlas.com//images/dishes/37a5c7e2ca0f45aca4111c3b06796b1d.jpg?width=660&height=420", resturnatNames: "Muddy Creek Tavern",
                    calories: 120),
             
             Dishes(id: "item2",
                    name: "Gyoza",
                    description: "The famous Japanese gyoza are crescent-shaped dumplings that have originated from the traditional Chinese jiaozi dumplings. The recipe was slightly altered to accommodate the Japanese taste, and gyoza soon became one of the favorite Japanese meals.",
                    image: "https://cdn.tasteatlas.com//Images/Dishes/3c16ad904018488f8c363413d356cacc.jpg?width=660&height=420", resturnatNames: "Countryside Cravings",
                    calories: 132),
             
             Dishes(id: "item3",
                    name: "Nachos",
                    description: "The first, original plate of nachos consisting of tortilla chips, melted chips, and jalapeños was made for a group of military officers' wives in 1943 in Piedras Negras, Mexico. The ladies of the US Army Air Force base went over to a restaurant in the city, called the Victory Club.",
                    image: "https://cdn.tasteatlas.com//images/dishes/a29fe2d3d9c54547a9e49c49f5cf22cd.jpg?width=660&height=420", resturnatNames: "Hog Heaven",
                    calories: 423),
             
             Dishes(id: "item4",
                    name: "Quesadilla",
                    
                    description: "Quesadilla is a simple Mexican snack consisting of a flour or corn tortilla filled with cheese that melts well. It is commonly folded in half and consumed. A quesadilla can also have some other ingredients on the inside such as meats, beans, or potatoes, but cheese is always mandatory (with the exception of Mexico City, where cheese in a quesadilla is often an afterthought).",
                    image: "https://cdn.tasteatlas.com//images/dishes/cde29cfce09c43b0acc43e19a77b845b.jpg?width=660&height=420", resturnatNames: "Rustic Eats",
                    calories: 827)
         ]
         
         self.dishesData = dishesData
         self.tableview.reloadData()
    }
}
