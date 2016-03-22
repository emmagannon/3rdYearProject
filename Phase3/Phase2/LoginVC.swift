//
//  LoginVC.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 10/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signinButtonTapped(sender: UIButton) {
        
        let username = usernameTextField.text;
        let password = passwordTextField.text;
        
        let usernameStored = NSUserDefaults.standardUserDefaults().stringForKey("username");
        let passwordStored = NSUserDefaults.standardUserDefaults().stringForKey("password");
        
        if(usernameStored == username)
        {
            if(passwordStored == password)
            {
                // login is sucessful
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn");
                NSUserDefaults.standardUserDefaults().synchronize()
                
                //self.dismissViewControllerAnimated(true, completion: nil)
                self.performSegueWithIdentifier("selectStudentView", sender:self);
            }
        }
        
        
        // check for empty fields
        if(username!.isEmpty || password!.isEmpty)
        {
            // display error message
            displayMyErrorMessage("All Fields are required");
            return;
        }
        
        // check if the details entered match the stored ones
        if(username != usernameStored || password != passwordStored)
        {
            displayMyErrorMessage("Incorrect information");
        }
    }


    func displayMyErrorMessage(userMessage:String)
    {
        
        var myError = UIAlertController(title:"Error", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert);
        
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.Default, handler:nil);
        
        myError.addAction(okAction);
        
        self.presentViewController(myError, animated:true, completion:nil)
        
    }


}
