//
//  AuthViewController.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit
import Mixpanel

class AuthViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailPlaceholderLabel: UILabel!
    @IBOutlet weak var passPlaceholderLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var emailBottomLineView: UIView!
    @IBOutlet weak var passBottomLineView: UIView!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var emailPlaceholderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var passPlaceholderTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var baseBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    
    var actualPassword: NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Mixpanel.mainInstance().track(event: "Auth Screen")
        
        configureInterface()
        registerNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    deinit {
        
        deregisterNotifications()
    }
    
    //MARK: - Interface
    func configureInterface() {

        self.title = NSLocalizedString("Auth.Navigation.Title", comment: "")
        
        //Показываем навигационную панель
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        //Кнопка "Забыли пароль?"
        self.forgotButton.layer.cornerRadius = 4.0
        self.forgotButton.layer.masksToBounds = true
        self.forgotButton.layer.borderColor = UIColor.colorFrom(hex: "ebebeb").cgColor
        self.forgotButton.layer.borderWidth = 0.5
        
        //Скрытие клавиатуры по тапу
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    //MARK: - Notifications
    func registerNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func deregisterNotifications() {
        
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - Keyboard
    func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if self.baseBottomConstraint.constant != 0.0 {
            
            return
        }
        
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
        let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        
        self.baseBottomConstraint.constant += (keyboardSize?.height)!
        UIView.animate(withDuration: duration!, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
        
        self.baseBottomConstraint.constant = 0.0
        UIView.animate(withDuration: duration!, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: - Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            
            if textField.empty() {
            
                upEmailPlaceholder()
            }
        } else if textField == self.passTextField {
            
            if textField.empty() {
                
                upPassPlaceholder()
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == self.emailTextField {
            
            if textField.empty() {
                
                downEmailPlaceholder()
            }
        } else if textField == self.passTextField {
            
            if textField.empty() {
                
                downPassPlaceholder()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Для изменения dots в поле пароля
        if textField == self.passTextField {

            self.actualPassword = NSString(format: "%@", self.actualPassword.replacingCharacters(in: range, with: ""))
            self.actualPassword = NSString(format: "%@%@", self.actualPassword, string)
            
            var index = 0
            var dotsStr = ""
            while index < self.actualPassword.length {
                
                dotsStr += "*"
                index += 1
            }
            
            textField.text = dotsStr
        
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.emailTextField {
            
            self.passTextField.becomeFirstResponder()
        
        } else if textField == self.passTextField {
            
            dismissKeyboard()
            doAuth()
        }
        
        return true
    }
    
    //MARK: - Data
    func doAuth() {
        
        if !(self.emailTextField.text?.isEmailValid)! {
            
            let title = NSLocalizedString("Auth.Email.Invalid.Title", comment: "")
            let message = NSLocalizedString("Auth.Email.Invalid.Message", comment: "")
            self.showNotificationErrorWith(title: title, message: message, duration: 3.0)
            
            self.emailTextField.becomeFirstResponder()
            
            return
        }
        
        if !(String(self.actualPassword).isPasswordValid) {
            
            let title = NSLocalizedString("Auth.Password.Invalid.Title", comment: "")
            let message = NSLocalizedString("Auth.Password.Invalid.Message", comment: "")
            self.showNotificationErrorWith(title: title, message: message, duration: 6.0)
            
            self.passTextField.becomeFirstResponder()
            
            return
        }
        
        dismissKeyboard()
        
        if !self.hasConnectivity() {
            
            let title = NSLocalizedString("No.Connection.Title", comment: "")
            let message = NSLocalizedString("No.Connection.Message", comment: "")
            self.showNotificationErrorWith(title: title, message: message, duration: 5.0)
            
            return
        }
        
        showLoader()
        
        let request = WeatherRequestModel()
        request.city = "Moscow"
        
        AuthorizationRequestManager.doAuthWith(model: request, success: { (response: WeatherResponseModel) in
            
            let title = NSLocalizedString("Auth.Success.Title", comment: "")
            var message: String!
            if !response.weather.isEmpty {
                
                message = String(format: NSLocalizedString("Auth.Success.Message", comment: ""), response.weather[0].description, String((response.temperature?.temp)!))
                
            } else {
                
                message = NSLocalizedString("Auth.Success.Message", comment: "")
            }
            
            self.showAlertWith(title: title, message: message, complition: {
                
                self.navigationController?.popViewController(animated: true)
            })
            
            self.hideLoader()
            
        }, failure: {
            
            let title = NSLocalizedString("Alert.Bad.Common.Tittle", comment: "")
            let message = NSLocalizedString("Alert.Bad.Common.Message", comment: "")
            self.showNotificationErrorWith(title: title, message: message, duration: 5.0)
            
            self.hideLoader()
        })
    }
    
    //MARK: - Loader
    func showLoader() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        self.loadingView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            
            self.loadingView.alpha = 0.2
        })
    }
    
    func hideLoader() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        UIView.animate(withDuration: 0.3, animations: {
        
            self.loadingView.alpha = 0.0
            
        }, completion: {(finished: Bool) in
            
            self.loadingView.isHidden = true
        })
    }
    
    //MARK: - Placeholders
    func upEmailPlaceholder() {
        
        self.emailPlaceholderTopConstraint.constant -= 20.0
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func downEmailPlaceholder() {
        
        self.emailPlaceholderTopConstraint.constant += 20.0
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func upPassPlaceholder() {
        
        self.passPlaceholderTopConstraint.constant -= 20.0
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func downPassPlaceholder() {
        
        self.passPlaceholderTopConstraint.constant += 20.0
        UIView.animate(withDuration: 0.2, animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    //MARK: - IB Actions
    @IBAction func forgotButtonPressed(_ sender: Any) {
        
        let title = NSLocalizedString("Auth.Forgot.Title", comment: "")
        let message = NSLocalizedString("Auth.Forgot.Text", comment: "")
        self.showErrorWith(title: title, message: message)
    }
    
    @IBAction func authButtonPressed(_ sender: Any) {
        
        doAuth()
    }
}
