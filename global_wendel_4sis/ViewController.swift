//
//  ViewController.swift
//  global_wendel_4sis
//
//  Created by Wendel Silvestre on 28/05/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button1 = UIButton(type: .system)
        button1.setTitle("Person 1", for: .normal)
//        button1.frame = CGRect(x: 100, y: 150, width: 200, height: 50)

        button1.addAction(UIAction { _ in
            self.show(PersonViewController(), sender: self)
        }, for: .touchUpInside)

        view.addSubview(button1)

        
        let button2 = UIButton(type: .system)
        button2.setTitle("Mode 2", for: .normal)
//        button2.frame = CGRect(x: 100, y: 250, width: 200, height: 50)

        button2.addAction(UIAction { _ in
            self.show(ModeViewController(), sender: self)
        }, for: .touchUpInside)

        view.addSubview(button2)


        let button3 = UIButton(type: .system)
        button3.setTitle("Log 3", for: .normal)
//        button3.frame = CGRect(x: 100, y: 350, width: 200, height: 50)

        button3.addAction(UIAction { _ in
            self.show(LogViewController(), sender: self)
        }, for: .touchUpInside)

        view.addSubview(button3)
        
    }


}

