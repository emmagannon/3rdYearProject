//
//  RegisterVC.swift
//  LetterWritingCheker
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
            displayMyErrorMessage("All fields are required");
            return;
        }
        
        // check if passwords match
        if(password != confirmPassword)
        {
            //display alert message
            displayMyErrorMessage("Passwords do not match");
            return;
            
        }
        
        // store data
        
        NSUserDefaults.standardUserDefaults().setObject(email, forKey:"email");
        NSUserDefaults.standardUserDefaults().setObject(username, forKey:"username");
        NSUserDefaults.standardUserDefaults().setObject(password, forKey:"password");
        
        NSUserDefaults.standardUserDefaults().synchronize();
        
        // display confirmation message
        
        let myError = UIAlertController(title:"Complete", message:"Registration Successful", preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default)
        {
            action in
            self.dismissViewControllerAnimated(true, completion:nil)
        }
        
        myError.addAction(okAction);
        self.presentViewController(myError, animated:true, completion:nil)
        
    }
    
    func displayMyErrorMessage(userMessage:String)
    {
        
        var myError = UIAlertController(title:"Error", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil);
        
        myError.addAction(okAction);
        
        self.presentViewController(myError, animated:true, completion:nil)
        
    }

}
