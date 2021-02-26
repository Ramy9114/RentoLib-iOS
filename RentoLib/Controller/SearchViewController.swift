//
//  RentViewController.swift
//  RentoLib
//
//  Created by Rami Moubayed on 25/02/2021.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var ProductNameTextField: UITextField!
    @IBOutlet weak var ProductCategoryPickerView: UIPickerView!
    @IBOutlet weak var MinimumPriceTextField: UITextField!
    @IBOutlet weak var MaximumPriceTextField: UITextField!
    
    var userObject: User?
    var productSearchResult : [Product]?
    var productCategories =  [ProductCategory]()
    
    var selectedCategoryId : Int?
    var selectedCategory : String?
    var selectedSubcategoryId: Int?
    var selectedSubcategory: String?
    

    var searchManager = SearchManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchManager.delegate = self
        
        ProductCategoryPickerView.delegate = self
        ProductCategoryPickerView.dataSource = self
        
        fillPickerView()
    }
    
    @IBAction func SearchPressed(_ sender: UIButton) {
        
        if ProductNameTextField.text?.count == 0 ||
            MinimumPriceTextField.text?.count == 0 ||
            MaximumPriceTextField.text?.count == 0 ||
            selectedSubcategoryId == 0 ||
            selectedCategoryId == 0{
//            let productFilter = ProductFilter(productSubcategoryId: 0, productCategoryId: 0, name: "", priceFrom: 0, priceTo: 0, status: true)
            let productFilter = ProductFilter(productSubcategoryId: nil, productCategoryId: nil, name: nil, priceFrom: nil, priceTo: nil, status: nil)
            searchManager.searchForResults(productFilter, userObject!)
            
        } else {
            print("Going to search for relevant Items")
            let productFilter = ProductFilter(productSubcategoryId: selectedSubcategoryId!, productCategoryId: selectedCategoryId!, name: ProductNameTextField.text!, priceFrom: Float(MinimumPriceTextField.text!)!, priceTo: Float(MaximumPriceTextField.text!)!, status: true)
            searchManager.searchForResults(productFilter, userObject!)
            
        }
    }
    
}

//MARK: - Show Toast Function
extension SearchViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-500, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

//MARK: - UIPickerView Delegates
extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return productCategories.count
        }else {
            let selectedCategory = pickerView.selectedRow(inComponent: 0)
            return productCategories[selectedCategory].productSubcategories.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return productCategories[row].name
        }else {
            let selectedCategory = pickerView.selectedRow(inComponent: 0)
            return productCategories[selectedCategory].productSubcategories[row].name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ProductCategoryPickerView.reloadComponent(1)
        
        let selectedCategoryRow = pickerView.selectedRow(inComponent:0)
        let selectedSubcategoryRow = pickerView.selectedRow(inComponent: 1)
        selectedCategoryId = productCategories[selectedCategoryRow].productCategoryId
        selectedCategory = productCategories[selectedCategoryRow].name
        selectedSubcategoryId = productCategories[selectedCategoryRow].productSubcategories[selectedSubcategoryRow].productSubcategoryId
        selectedSubcategory = productCategories[selectedCategoryRow].productSubcategories[selectedSubcategoryRow].name
//        print("Selected Category: \(selectedCategory), Selected Subcategory: \(selectedSubcategoryId ?? 0)")
        
    }
    
    func fillPickerView(){
        productCategories.append(ProductCategory(productCategoryId: 0, name: "", productSubcategories:[ProductSubcategory(productSubcategoryId: 0, name: "")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Vehicles", productSubcategories:[ProductSubcategory(productSubcategoryId: 1, name: "Cars"), ProductSubcategory(productSubcategoryId: 2, name: "Moto"), ProductSubcategory(productSubcategoryId: 3, name: "Boat")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Real Estate", productSubcategories:[ProductSubcategory(productSubcategoryId: 4, name: "Appartments"), ProductSubcategory(productSubcategoryId: 5, name: "Houses"), ProductSubcategory(productSubcategoryId: 6, name: "Offices")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Sports", productSubcategories:[ProductSubcategory(productSubcategoryId: 7, name: "Football"), ProductSubcategory(productSubcategoryId: 8, name: "Basketball"), ProductSubcategory(productSubcategoryId: 9, name: "Golf")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Animals", productSubcategories:[ProductSubcategory(productSubcategoryId: 10, name: "Dogs"), ProductSubcategory(productSubcategoryId: 11, name: "Cats"), ProductSubcategory(productSubcategoryId: 12, name: "Reptiles")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Clothing", productSubcategories:[ProductSubcategory(productSubcategoryId: 13, name: "Jackets"), ProductSubcategory(productSubcategoryId: 14, name: "Suits"), ProductSubcategory(productSubcategoryId: 15, name: "Belts")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Multimedia", productSubcategories:[ProductSubcategory(productSubcategoryId: 16, name: "Laptops"), ProductSubcategory(productSubcategoryId: 17, name: "TVs"), ProductSubcategory(productSubcategoryId: 20, name: "Smartphones")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Services", productSubcategories:[ProductSubcategory(productSubcategoryId: 21, name: "Home Services"), ProductSubcategory(productSubcategoryId: 22, name: "Events"), ProductSubcategory(productSubcategoryId: 23, name: "Lecturing")]))
        
        productCategories.append(ProductCategory(productCategoryId: 1, name: "Pro Material", productSubcategories:[ProductSubcategory(productSubcategoryId: 24, name: "Tools"), ProductSubcategory(productSubcategoryId: 25, name: "Industrial Equipments"), ProductSubcategory(productSubcategoryId: 26, name: "Office Furnitures")]))
    }
    
    
}

//MARK: - SearchManagerDelegate
extension SearchViewController: SearchManagerDelegate {
    func SearchResultsGiven(_ searchManager: SearchManager, _ JsonResponseMessage: String, _ user: User, _ JsonResponse: [Product]) {
        print("performing segue")
        userObject = user
        productSearchResult = JsonResponse
        print(productSearchResult)
        self.showToast(message: JsonResponseMessage, font: .systemFont(ofSize: 20.0))
//        self.performSegue(withIdentifier: "goBackHome", sender: self)
    }
    
    func SearchFailWithError(errorMessage: String) {
        self.showToast(message: "Something went wrong", font: .systemFont(ofSize: 20.0))
    }
    
    
    
    
}
