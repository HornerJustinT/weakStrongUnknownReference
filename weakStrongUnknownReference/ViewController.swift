//
//  ViewController.swift
//  weakStrongUnknownReference
//
//  Created by Justin Horner on 7/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // We are looking at weak vs strong vs unknown
        // Reference counting only applies to reference based types ie Classes
        // Why is reference counting important? If the memory fills then the app fails then it crashes. Users don't like crashed programs
        // ARC Automatic reference counting from the swift documentation "It just works"
        // Every time a class instance is created through init ARC allocates memory for it.
        // When the code is non longer needed deinit is used to remove its memory allocation
        // for reqs of reference type everthing can be strong
        // var and optional can be weak
        //unowned can be var let and non-optional
        // Things are automatically created as strong
        //With the property labelled as weak, it will not increment the reference count
        //An unowned reference falls in between, they are neither strong nor or type optional. Compiler will assume that object is not deallocated as the reference itself remain allocated.
        var kelvin: Person?
        var iphone: Gadget?


        kelvin = Person(name: "Kelvin")
        iphone = Gadget(model: "iPhone 8 Plus")
        kelvin!.gadget = iphone// if these are removed the classes get deinit
        iphone!.owner = kelvin // there is a strong relationship between instance of kelvin's property gadget and gadget's instance
        // if one of the properties is not set (ex kelvin!.gadget) they both get deinit
        // this is called a strong reference cycle, even if they are both set to nil they don't get deinit.
        kelvin = nil
        iphone = nil
        // with this strong reference type if the instance of class kelvin also references one of its properties of another class the classes never deinit
        print(kelvin?.gadget)
        // they are nil now but still don't get deinit staying and hogging up the memory allocation.
        // strong reference cycles happen when their is a strong reference between two classes. Without a a different reference type, it is impossible to delete either class.
    }

    class Person {
        let name: String
        init(name: String) {
            self.name = name
            print("\(name) is being initialized")
        }
        weak var gadget: Gadget? // if we make this property weak it should stop a strong reference cycle.
        deinit {
            print("\(name) is being deinitialized")
        }
    }
     
    class Gadget {
        let model: String
        init(model: String) {
            self.model = model
            print("\(model) is being initialized")
        }
        var owner: Person?
        deinit {
            print("\(model) is being deinitialized")
        }
    }
    // two classes made to show when something is being initialized
}

