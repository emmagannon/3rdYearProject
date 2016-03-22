//
//  ModelManager.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 14/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

//import Foundation
import UIKit


let sharedInstance = ModelManager()

class ModelManager: NSObject
{

    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Student.sqlite"))
        }
        return sharedInstance
    }
    
    func addStudentData(studentInfo: StudentInfo) -> Bool
    {
        sharedInstance.database!.open()
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO student_info (Name) VALUES (?)", withArgumentsInArray: [studentInfo.Name])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE student_info SET Name=? WHERE RollNo=?", withArgumentsInArray: [studentInfo.Name, studentInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM student_info WHERE RollNo=?", withArgumentsInArray: [studentInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    func getAllStudentData() -> NSMutableArray {
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM student_info", withArgumentsInArray: nil)
        let marrStudentInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {
            while resultSet.next() {
                let studentInfo : StudentInfo = StudentInfo()
                studentInfo.RollNo = resultSet.stringForColumn("RollNo")
                studentInfo.Name = resultSet.stringForColumn("Name")
                marrStudentInfo.addObject(studentInfo)
            }
        }
        sharedInstance.database!.close()
        return marrStudentInfo
    }
   
}