//
//  RightViewController.swift
//  nestor
//
//  Created by milliere on 02/10/2016.
//  Copyright © 2016 milliere. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RightViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextfield: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var subCategory: UITextField!
    @IBOutlet weak var sliderPrice: UISlider!
    @IBOutlet weak var textFieldLowerValue: UILabel!
    @IBOutlet weak var seach: UIButton!
    
    @IBOutlet weak var delete_info: UIButton!
    
    var paramsSearch = [String:AnyObject]()
    
    @IBAction func send_search(_ sender: UIButton) {
        
    }
    
    @IBAction func delete_info(_ sender: UIButton) {
        
        self.dateTextField.text = ""
        self.timeTextfield.text = ""
        self.category.text = ""
        self.subCategory.text = ""
    }
    
    var pickerViewCategory = UIPickerView()
    var pickerViewSubCategory = UIPickerView()
    
    var boolSubCategory = false
    var categoryId: Int!
    var SubcategoryId: Int!
    
    var pickOption = ["Théâtre", "Danse", "Comédie musicale", "Opéra", "Cirque", "Exposition", "Dégustation", "Jeune public", "Concerts", "Arts de rue", "Cinéma", "Conférence", "Festival", "Visite guidée", "Atelier", "Expo-vente"]
    var pickSubCategory = [AnyObject]()
    var _subCategoriesArray = [String]()
    var _subCategoriesArrayId = [Int]()

    @IBAction func sliderValueChangedPrice(_ sender: UISlider) {
        let price = Int(sender.value)
        textFieldLowerValue.text = "\(price)"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.dateTextField.delegate = self
        self.timeTextfield.delegate = self
        self.category.delegate = self
        self.subCategory.delegate = self
        self.pickerViewCategory.delegate = self
        self.pickerViewSubCategory.delegate = self
        self.pickerViewCategory.dataSource = self
        self.pickerViewSubCategory.dataSource = self
        self.pickerViewCategory.tag = 1
        self.pickerViewSubCategory.tag = 2
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 40, width: 0, height: 0))
        
        if textField.tag == 1 {
            datePickerView.datePickerMode = UIDatePickerMode.date
        }
        
        if textField.tag == 2 {
            datePickerView.datePickerMode = UIDatePickerMode.time
        }
        
        
        if textField.tag == 3 {
            boolSubCategory = false
            category.inputView = pickerViewCategory
        }
        
        
        if textField.tag == 4 {
            boolSubCategory = true
            
            if _subCategoriesArray.isEmpty == false{
                subCategory.inputView = pickerViewSubCategory
            }else{
                subCategory.resignFirstResponder()
                subCategory.text = ""
                
                let alertController = UIAlertController(title: "Pas de sous-catégorie", message: "pour la categorie \(category.text!)", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil)
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
        }
        
        
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneButton.setTitle("Done", for: UIControlState())
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState())
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        
        let doneTimeButton = UIButton(frame: CGRect(x: (self.view.frame.size.width/2) - (100/2), y: 0, width: 100, height: 50))
        doneTimeButton.setTitle("Done", for: UIControlState())
        doneTimeButton.setTitle("Done", for: UIControlState.highlighted)
        doneTimeButton.setTitleColor(UIColor.black, for: UIControlState())
        doneTimeButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        
        
        if textField.tag == 1 {
            dateTextField.inputView = inputView
            datePickerView.addTarget(self, action: #selector(RightViewController.handleDatePicker(_:)), for: UIControlEvents.valueChanged)
            handleDatePicker(datePickerView)
            
            inputView.addSubview(doneButton) // add Button to UIView
            doneButton.addTarget(self, action: #selector(RightViewController.doneButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        }
        
        if textField.tag == 2 {
            timeTextfield.inputView = inputView
            datePickerView.addTarget(self, action: #selector(RightViewController.handleTimePicker(_:)), for: UIControlEvents.valueChanged)
            handleTimePicker(datePickerView)
            
            inputView.addSubview(doneTimeButton) // add Button to UIView
            doneTimeButton.addTarget(self, action: #selector(RightViewController.doneTimeButton(_:)), for: UIControlEvents.touchUpInside) // set button click event
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func handleTimePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "H:mm"
        timeTextfield.text = dateFormatter.string(from: sender.date)
        
    }
    
    func doneButton(_ sender:UIButton)
    {
        
        dateTextField.resignFirstResponder()
    }
    
    func doneTimeButton(_ sender:UIButton)
    {
        timeTextfield.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == pickerViewCategory {
            return pickOption.count
            
        }else if pickerView == pickerViewSubCategory {
            return _subCategoriesArray.count
            
        }
        
        return 0
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewCategory {
            return pickOption[row]
            
            
        }else if pickerView == pickerViewSubCategory {
            return _subCategoriesArray[row]
            
        }
        return " "
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if category.tag == 3 && !boolSubCategory {
            category.text = self.pickOption[row]
            categoryId = row + 1
            subCategory(categoryId)
            
            category.resignFirstResponder()
            NotificationCenter.default.addObserver(self, selector: #selector(RightViewController.refreshPickerView(_:)), name: NSNotification.Name(rawValue: "refresh"), object: nil)
            
            
        }
        
        
        if subCategory.tag == 4 && boolSubCategory {
            
            subCategory.text = _subCategoriesArray[row]
            SubcategoryId = _subCategoriesArrayId[row]
            subCategory.resignFirstResponder()
        }
    }
    
    func  subCategory(_ id:Int ) {
        
        Alamofire.request("http://vps124843.ovh.net/api/v1/events/sub-category", method: .get, parameters: ["catg_id": id] )
            .responseJSON { response in
                if let value = response.result.value {
                    let json = JSON(value)
                    self._subCategoriesArray.removeAll()
                    self._subCategoriesArrayId.removeAll()
                    for index in 0 ..< json["events"].count {
                        
                        self._subCategoriesArray.append(json["events"][index]["name"].stringValue)
                        self._subCategoriesArrayId.append(json["events"][index]["id"].intValue)
                        
                    } // end for
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "refresh"), object: nil, userInfo: nil)
                }
        }
    
    }
    
    func refreshPickerView(_ notification: Notification) {
        self.subCategory.text = ""
        self.pickerViewSubCategory.reloadAllComponents()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (category.text != "") {
            
            self.paramsSearch.updateValue(categoryId as AnyObject, forKey: "events[catg]")
        }
        
        if (subCategory.text != "") {
            self.paramsSearch.updateValue(SubcategoryId as AnyObject, forKey: "events[sub_catg]")
        }
        
        if (dateTextField.text != "") {
            self.paramsSearch.updateValue(dateTextField.text! as AnyObject, forKey: "events[date]")
        }
        
        if (timeTextfield.text != "") {
            self.paramsSearch.updateValue(timeTextfield.text! as AnyObject, forKey: "events[time]")
        }
        
        
        self.paramsSearch.updateValue(0 as AnyObject, forKey: "events[min_price]")
        
        self.paramsSearch.updateValue(Int(textFieldLowerValue.text!)! as AnyObject, forKey: "events[max_price]")
        
        
        
        if segue.identifier == "search" {
            print("je suis dans le segue \(self.paramsSearch)")
            (segue.destination as! MainViewController).searchParams = self.paramsSearch
            
        }
    }
}
