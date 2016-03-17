//
//  SelectStudentVC.swift
//  Phase2
//
//  Created by Emma Gannon on 11/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class SelectStudentVC: UIViewController, UITableViewDataSource,UITableViewDelegate
{    
    var marrStudentData : NSMutableArray!
    
    @IBOutlet weak var tbStudentData: UITableView!
    @IBOutlet weak var studentNameTextField: UITextField!
    var isEdit : Bool = false
    var studentData : StudentInfo!
    
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        if(isEdit)
        {
            studentNameTextField.text = studentData.Name;
            //txtMarks.text = studentData.Marks;
        }

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.getStudentData()
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getStudentData()
    {
        marrStudentData = NSMutableArray()
        marrStudentData = ModelManager.getInstance().getAllStudentData()
        tbStudentData.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marrStudentData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:StudentCell = tableView.dequeueReusableCellWithIdentifier("cell") as! StudentCell
        let student:StudentInfo = marrStudentData.objectAtIndex(indexPath.row) as! StudentInfo
        cell.lblContent.text = "Name : \(student.Name)  \n  Marks :"
        cell.DeleteButton.tag = indexPath.row
        //cell.btnEdit.tag = indexPath.row
        return cell
    }
    
  

    @IBAction func DeleteButtonTapped(sender: UIButton) {
        let DeleteButton : UIButton = sender as! UIButton
        let selectedIndex : Int = DeleteButton.tag
        let studentInfo: StudentInfo = marrStudentData.objectAtIndex(selectedIndex) as! StudentInfo
        let isDeleted = ModelManager.getInstance().deleteStudentData(studentInfo)
        if isDeleted {
            Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
        }
        self.getStudentData()
    }

    @IBAction func AddNameButtonTapped(sender: UIButton)
    {
        if(studentNameTextField.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter student name.", delegate: nil)
        }
        else
        {
            if(isEdit)
            {
                let studentInfo: StudentInfo = StudentInfo()
                studentInfo.RollNo = studentData.RollNo
                studentInfo.Name = studentNameTextField.text!
                //studentInfo.Marks = txtMarks.text!
                let isUpdated = ModelManager.getInstance().updateStudentData(studentInfo)
                if isUpdated {
                    Util.invokeAlertMethod("", strBody: "Record updated successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in updating record.", delegate: nil)
                }
            }
            else
            {
                let studentInfo: StudentInfo = StudentInfo()
                studentInfo.Name = studentNameTextField.text!
                //studentInfo.Marks = txtMarks.text!
                let isInserted = ModelManager.getInstance().addStudentData(studentInfo)
                if isInserted {
                    Util.invokeAlertMethod("", strBody: "Record Inserted successfully.", delegate: nil)
                } else {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            }
            self.navigationController?.popViewControllerAnimated(true)
            self.getStudentData()
        }
}
}
