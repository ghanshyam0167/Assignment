//
//  FoodTableViewController.swift
//  MealTracker
//
//  Created by GS Agrawal on 18/08/25.
//

import UIKit

class FoodTableViewController: UITableViewController {

    var meals : [Meal] {
        return [
            Meal(
                name: "Breakfast",
                food: [
                    Food(name: "Pancakes", description: "Fluffy pancakes served with syrup"),
                    Food(name: "Omelette", description: "Egg omelette with vegetables"),
                    Food(name: "Toast", description: "Buttered toast with jam")
                ]
            ),
            Meal(
                name: "Lunch",
                food: [
                    Food(name: "Grilled Chicken", description: "Chicken breast grilled with spices"),
                    Food(name: "Caesar Salad", description: "Fresh lettuce with dressing and croutons"),
                    Food(name: "Rice & Curry", description: "Steamed rice served with spicy curry")
                ]
            ),
            Meal(
                name: "Dinner",
                food: [
                    Food(name: "Pasta", description: "Pasta in creamy Alfredo sauce"),
                    Food(name: "Soup", description: "Hot tomato soup with herbs"),
                    Food(name: "Steak", description: "Juicy grilled steak with seasoning")
                ]
            ) 
        ]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals[section].food.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "\(meals[indexPath.section].food[indexPath.row].name)"
        content.secondaryText = "\(meals[indexPath.section].food[indexPath.row].description)"
        cell.contentConfiguration = content
        // Configure the cell...
        cell.showsReorderControl = true

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(meals[section].name)"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        

    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
