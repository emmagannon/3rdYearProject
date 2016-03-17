//
//  RegisterVC.swift
//  Phase2
//
//  Created by Emma Gannon on 09/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func confirmButtonTapped(sender: UIButton) {
        
        let email = emailTextField.text;
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        let confirmPassword = confirmPasswordTextField.text;
        
        // check for empty fields
        if(email!.isEmpty || username!.isEmpty || password!.isEmpty || confirmPassword!.isEmpty)
        {
            
            // display alert message
            displayMyAlertMessage("All Fields are required");
            return;
        }
        
        // check if passwords match
        if(password != confirmPassword)
        {
            //display alert message
            displayMyAlertMessage("Passwords do not match");
            return;
            
        }
        
        // store data
        
        NSUserDefaults.standardUserDefaults().setObject(email, forKey:"email");
        NSUserDefaults.standardUserDefaults().setObject(username, forKey:"username");
        NSUserDefaults.standardUserDefaults().setObject(password, forKey:"password");
        
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // display confirmation message
        
        var myAlert = UIAlertController(title:"Error", message:"Registration Sucessful", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default)
        {
            action in
            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
        myAlert.addAction(okAction);
        self.presentViewController(myAlert, animated:true, completion:nil)
        
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        var myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.presentViewController(myAlert, animated:true, completion:nil)
        
    }

}
