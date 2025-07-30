//
//  SecondViewController.swift
//  Event management
//
//  Created by Student on 30/07/25.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("1. Second View Controller - VIew Did Load")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print("2. Second View will appear")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("3. Second View did appear")
    }
    override func viewWillDisappear(_ animated: Bool) {
        print("4. Second Screen will disappear")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("5. Second view did disppear")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
