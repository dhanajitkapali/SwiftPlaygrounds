import UIKit
import Foundation

struct TrafficColor{
    static let red = "red"
    static let green = "green"
    static let yellow = "yellow"
}

protocol TrafficLightObserver{
    var observerID : Int {get set}
    func onTrafficLightColorChange(_color : String)
}

//First observer
class VehicleObserver : TrafficLightObserver{
    var observerID: Int
    
    init(observerID : Int) {
        self.observerID = observerID
    }
    
    func onTrafficLightColorChange(_color : String){
        if(_color == TrafficColor.red){
            print("Vehicle-> stop my vehicle")
        }
        if(_color == TrafficColor.green){
            print("Vehicle-> start my vehicle")
        }
        if(_color == TrafficColor.yellow){
            print("Vehicle-> slow down the speed of vehicle")
        }
    }
}

class VendorObserver : TrafficLightObserver{
    var observerID: Int
    
    init(observerID : Int) {
        self.observerID = observerID
    }
    
    func onTrafficLightColorChange(_color : String){
        if(_color == TrafficColor.red){
            print("Vendor-> start selling the products")
        }
        if(_color == TrafficColor.green){
            print("Vendor-> Move aside the road")
        }
    }
}

//the Notifier OR Subject
class TrafficLightSubject{
    private var _color = String()
    
    var trafficLightColor : String{
        get{
            return _color
        }
        set{
            _color = newValue
            //notify observers when color is changed
            notifyObserver()
        }
    }
    
    //list of observers
    private var trafficObservers = [TrafficLightObserver]()
    
    //function to add new observers
    func addObserver(_observer : TrafficLightObserver){
        //add new observers if its not already in the list
        guard trafficObservers.contains(where: {$0.observerID == _observer.observerID}) == false else {
            return
        }
        trafficObservers.append(_observer)
    }
    
    func removeObserver(_observer : TrafficLightObserver){
        //filter in those observers whose observerID != _observer.observerID
        trafficObservers = trafficObservers.filter({$0.observerID != _observer.observerID})
    }
    
    //func to notify observers
    private func notifyObserver(){
        //invoke the function of the observers
        trafficObservers.forEach({$0.onTrafficLightColorChange(_color: _color)})
    }
    
    deinit {
        //remove all the observers from memory
        trafficObservers.removeAll()
    }
}


//lets play with the code
let trafficLightSubject = TrafficLightSubject()
let vehicleObserver = VehicleObserver(observerID: 1)
let vendorObserver = VendorObserver(observerID: 2)

trafficLightSubject.addObserver(_observer: vehicleObserver)
trafficLightSubject.addObserver(_observer: vendorObserver)
trafficLightSubject.removeObserver(_observer: vendorObserver)

trafficLightSubject.trafficLightColor = TrafficColor.red
