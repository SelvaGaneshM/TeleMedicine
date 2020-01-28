//
//  LoginViewController.swift
//  Saathi
//
//  Created by iGridiMac on 18/12/19.
//  Copyright © 2019 iGridiMac. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class LoginViewController: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var Signin: UIButton!
    @IBOutlet weak var Signup: UIButton!
    
    @IBOutlet weak var password_txt: DesignableUITextField!
    @IBOutlet weak var username_txt: DesignableUITextField!
      var index: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
           
    }
    override func viewWillAppear(_ animated: Bool)
       {
           super.viewWillAppear(animated)
        self.hideKeyboardWhenTappedAround()
           self.addKeyBoardObserver()
        
       }
       
       override func viewWillDisappear(_ animated: Bool)
       {
           super.viewWillDisappear(animated)
         
           self.removeKeyBoardObserver()
       }
    
//    @IBAction func Signin_act(_ sender: Any) {
//
//        if password_txt.text == "admin" || username_txt.text == "admin" {
//
//            // Safe Push VC
//                               if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "home_VC") as? HomeViewController {
//                                   if let navigator = navigationController {
//                                       navigator.pushViewController(viewController, animated: true)
//                                   }
//                               }
//
//        }
//    }
    @IBAction func Signin_act(_ sender: Any) {
            self.view.endEditing(true)
                   let userName = Commonfunction.shared.trimString(text: self.username_txt.text)
                   let password = Commonfunction.shared.trimString(text: self.password_txt.text)
                   if  userName != "" && password != ""
                   {
                       self.MedauthenticateUserDetail(username: userName, password: password)
                   }
                   else
                   {
                       _ = CustomAlertController.alert(title: "Alert", message: "Please check your credentials and try again.")
                   }
        }
        
      
            //MARK:- Med Login Service
             
             private func MedauthenticateUserDetail(username: String, password : String)
             {
             
                 CustomActivityIndicator.shared.showProgressView()
                  ServiceHelper.shared.MedLoginKPIs(userName: username, password: password){ (result, error) in
                     CustomActivityIndicator.shared.hideProgressView()
                     if let resultDict = result as? [String : Any]
                     {
                         print("USER \(resultDict)")
                        if ((resultDict["Status"] as? String) == "Success")
                         {
        //                     self.moveToLandingView(detailDict: resultDict["result"] as! [String : Any] )
                             CustomAlertController.alert(title: Constans.ErrorMessage.Alert, message: Commonfunction.shared.trimString(text: resultDict["ResponseText"] as? String))
                         }
                         else
                         {
                            CustomAlertController.alert(title: Constans.ErrorMessage.Alert, message: Commonfunction.shared.trimString(text: resultDict["ResponseText"] as? String))
                         }
                     }
                     else
                     {
                        CustomAlertController.alert(title: Constans.ErrorMessage.Alert, message: error!.localizedDescription)             }
                 }
             }
        
        @IBAction func Signup_act(_ sender: Any) {
        }
        //MARK:- KeyBoard notification
           
           @objc func keyboardWillShow(notification: NSNotification)
           {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
               {
                   if self.view.frame.origin.y == 0
                   {
                       self.animateAndMoveUpOrDown(up: true, moveValue: keyboardSize.height - 150)
                   }
               }
           }
           
           @objc func keyboardWillHide(notification: NSNotification)
           {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
               {
                   if self.view.frame.origin.y != 0
                   {
                       self.animateAndMoveUpOrDown(up: false, moveValue: keyboardSize.height - 150)
                   }
               }
           }
        
        //MARK:- Delegate
        //MARK:-- Text field
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            textField.resignFirstResponder()
            if textField.tag == 1
            {
                self.password_txt.becomeFirstResponder()
            }
            return true
        }
        
        //MARK:- Private Functions
        
        private func addKeyBoardObserver()
        {
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
        private func removeKeyBoardObserver()
        {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        private func animateAndMoveUpOrDown(up: Bool, moveValue: CGFloat)
         {
             let movementDuration:TimeInterval = 0.3
             let movement:CGFloat = ( up ? -moveValue  : moveValue)
             // Animation
             UIView.beginAnimations( "animateView", context: nil)
             UIView.setAnimationBeginsFromCurrentState(true)
             UIView.setAnimationDuration(movementDuration)
             self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
             UIView.commitAnimations()
         }
    }


    // Put this piece of code anywhere you like
    extension UIViewController {
        func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    }
    
