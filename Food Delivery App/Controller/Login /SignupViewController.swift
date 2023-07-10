

import UIKit

class SignupViewController: UITableViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgProfile.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        openGallery()
    }
    
    @IBAction func btnSignupClicked(_ sender: UIButton) {
        let imgSystem = UIImage(systemName: "person.crop.circle.badge.plus")
        
        if imgProfile.image?.pngData() != imgSystem?.pngData() {
            // profile image selected
            if let email = txtEmail.text, let password = txtPassword.text, let username = txtUsername.text, let conPassword = txtConPassword.text{
                if username == ""{
                    openAlert(title: "Alert", message: "Please enter username", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                }else if !email.validateEmailId(){
                    openAlert(title: "Alert", message: "Please enter valid email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    print("email is not valid")
                }else if !password.validatePassword(){
                    openAlert(title: "Alert", message: "Password is not valid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                } else{
                    if conPassword == ""{
                        openAlert(title: "Alert", message: "Password is not valid", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                    } else {
                        if password == conPassword{
                            // navigation code
                            navigationController?.setNavigationBarHidden(false, animated: true)
                            UserDefaults.standard.setValue(txtEmail.text, forKey: "email")
                            UserDefaults.standard.setValue(txtUsername.text, forKey: "personname")
                            UserDefaults.standard.setValue(imgProfile.image?.jpegData(compressionQuality: 0.5), forKey: "userimage")
                            self.navigationController?.popToRootViewController(animated: true)
                        }else{
                            openAlert(title: "Alert", message: "password does not match", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                        }
                    }
                }
            }else{
                openAlert(title: "Alert", message: "Please check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            }
        } else if imgProfile.image?.pngData() == imgSystem?.pngData() {
            print("Please select profile picture")
            openAlert(title: "Alert", message: "Please select profile picture", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let tableViewHeight = self.tableView.frame.height
        let contentHeight = self.tableView.contentSize.height
        
        let centeringInset = (tableViewHeight - contentHeight) / 2.0
        let topInset = max(centeringInset, 0.0)
        
        self.tableView.contentInset = UIEdgeInsets(top: topInset, left: 0.0, bottom: 0.0, right: 0.0)
    }
}


// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension SignupViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            present(picker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[.originalImage] as? UIImage{
            imgProfile.image = img
        }
        dismiss(animated: true)
    }
}


extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.txtUsername:
            self.txtEmail.becomeFirstResponder()
           case self.txtEmail:
            self.txtPassword.becomeFirstResponder()
        case self.txtPassword:
         self.txtConPassword.becomeFirstResponder()
           default:
               self.txtConPassword.resignFirstResponder()
           }
        return true
    }
}
