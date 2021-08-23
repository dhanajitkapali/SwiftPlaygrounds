import UIKit

class Bank : NSObject{
    @objc dynamic var customerName : String
    @objc dynamic var phoneNumber : String
    @objc dynamic private var age : Int = 0
    @objc var nickNames = ["nickName1", "nickName2"]
    
    init(customerName : String, phoneNumber : String) {
        self.customerName = customerName
        self.phoneNumber = phoneNumber
    }
}

let obj = Bank(customerName: "Dhanajit", phoneNumber: "123")
print(obj.customerName)

//KVC
let phone = obj.value(forKey: "phoneNumber") as! String
print(phone)

obj.setValue("name2", forKey: "customerName")
print(obj.customerName)

obj.setValue("name3", forKey: #keyPath(Bank.customerName))
print(obj.customerName)

obj.setValuesForKeys(["customerName": "name4" , "phoneNumber" : "12345"])
print(obj.customerName)
print(obj.phoneNumber)

/// KVC lets you access the private member of swift class
extension Bank{
    var ageValue : Int {
        let age = value(forKey: "age") as? Int ?? 0
        return age
    }
}
print(obj.ageValue)     //actually getting a value of a private member

let mutableArray = obj.mutableArrayValue(forKey: #keyPath(Bank.nickNames))
mutableArray.add("Mr singh")
print(obj.nickNames)


//KVO
///For KVO implement KVC first
///This will be invoked anytime the value of the "phoneNumber" changes
let observer = obj.observe(\.phoneNumber, options: [.new, .old]) { Bank, theValue in
    print(theValue.oldValue as Any)
    print(theValue.newValue as Any)
}

obj.phoneNumber = "725"
observer.invalidate()       //deallocate the observer
