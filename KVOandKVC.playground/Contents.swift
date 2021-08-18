import UIKit

class Bank : NSObject{
    @objc dynamic var customerName : String
    @objc dynamic var phoneNumber : String
    
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

//KVO
///This will be invoked anytime the value of the "phoneNumber" changes
let observer = obj.observe(\.phoneNumber, options: [.new, .old]) { Bank, theValue in
    print(theValue.oldValue as Any)
    print(theValue.newValue as Any)
}

obj.phoneNumber = "725"
