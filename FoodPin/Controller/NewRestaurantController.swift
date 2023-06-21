//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by Shaunak Mehta on 09/06/23.
//

import UIKit
import CoreData



class NewRestaurantController: UITableViewController {
    
    
    
    var selectedRestaurant = [String:String]()
    var isFromEdit = false
    var selectedImage = Data()
    
    var flag = false;
    
    var initRes = [String:String]()
    var initImage = Data()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the navigation bar appearance
        if let appearance = navigationController?.navigationBar.standardAppearance {
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
            }
            
            if(isFromEdit)
            {
                
                navigationItem.title = "Edit Restaurant"
                nameTextField.text = selectedRestaurant["name"]
                typeTextField.text = selectedRestaurant["type"]
                phoneTextField.text = selectedRestaurant["phone"]
                addressTextField.text = selectedRestaurant["location"]
                descriptionTextView.text = selectedRestaurant["desc"]
                photoImageView.image = UIImage(data: selectedImage)
                
                initRes["name"] = nameTextField.text
                initRes["type"] = typeTextField.text
                initRes["phone"] = phoneTextField.text
                initRes["address"] = addressTextField.text
                initRes["desc"] = descriptionTextView.text
                
                initImage = selectedImage
                
            }
            
            
            
            
            
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            
            let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
        
        
    }
    
    var restaurant: Restaurant!
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
            
        }
    }
    
    
    
    
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
        
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 10.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    
    @IBAction func noEditsDone(_ sender: UIBarButtonItem)
    {
        
        if(!isFromEdit)
        {
            dismiss(animated: true
            )
        }
        
        if(isFromEdit)
        {
            nameTextField.text = initRes["name"]
            typeTextField.text = initRes["type"]
            phoneTextField.text = initRes["phone"]
            addressTextField.text = initRes["address"]
            descriptionTextView.text = initRes["desc"]
            photoImageView.image = UIImage(data: initImage)
            
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                
                
                restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text!
                restaurant.type = typeTextField.text!
                restaurant.location = addressTextField.text!
                restaurant.phone = phoneTextField.text!
                restaurant.summary = descriptionTextView.text
                restaurant.isFavorite = false
                
                if let imageData = photoImageView.image?.pngData() {
                    restaurant.image = imageData
                }
                
                
                print("Saving data to context...")
                appDelegate.saveContext()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    
    
    

    
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        
        
        
            if nameTextField.text?.isEmpty == true || addressTextField.text?.isEmpty == true || phoneTextField.text?.isEmpty == true || typeTextField.text?.isEmpty==true || descriptionTextView.text?.isEmpty==true{
                    // Display an alert
                    let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                    
                    // Add an action to the alert
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    
                    // Present the alert
                    present(alert, animated: true, completion: nil)
                    
                    // Exit the method without saving
                    return
                }
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                
                
                restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text!
                restaurant.type = typeTextField.text!
                restaurant.location = addressTextField.text!
                restaurant.phone = phoneTextField.text!
                restaurant.summary = descriptionTextView.text
                restaurant.isFavorite = false
                
                if let imageData = photoImageView.image?.pngData() {
                    restaurant.image = imageData
                }
                
                
                print("Saving data to context...")
                appDelegate.saveContext()
                
                
                
                
            }
            
        
        if(!isFromEdit)
        {
            dismiss(animated: true, completion: nil)
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
        
            
            // Print values of other text fields, if any
        
        
        
        
    }
    
    
    
    
    
//        func showAlert(message: String) {
//            if let topViewController = getTopViewController() {
//                let alert = UIAlertController(title: "Oops", message: message, preferredStyle: .alert)
//                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//                alert.addAction(okAction)
//
//                topViewController.present(alert, animated: true, completion: nil)
//
//            }
//        }
//
//
//        func getTopViewController() -> UIViewController? {
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//               let mainWindow = windowScene.windows.first(where: { $0.isKeyWindow }),
//               let rootViewController = mainWindow.rootViewController {
//                var topViewController = rootViewController
//                while let presentedViewController = topViewController.presentedViewController {
//                    topViewController = presentedViewController
//                }
//                return topViewController
//            }
//            return nil
//        }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            let photoLibraryAction = UIAlertAction(title: "Photo library", style: .default, handler: { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    imagePicker.delegate = self
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            })
            
            
            let cancelAction = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
            
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            photoSourceRequestController.addAction(cancelAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
            
            
            
            
        }
        else{
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }
    
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
        }
    }
    
    
    
    
    
    
    
    
    
    // MARK: - Table view data source
    
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension NewRestaurantController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}


extension NewRestaurantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
    
}


