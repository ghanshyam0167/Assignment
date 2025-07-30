//
//  ResultsVIewController.swift
//  PersonalityQuiz
//
//  Created by GS Agrawal on 23/07/25.
//

import UIKit

class ResultsVIewController: UIViewController {
    var response : [Answer]
    init?(coder: NSCoder, response: [Answer]){
        self.response = response
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @IBOutlet weak var resultAnswerLabel: UILabel!
    @IBOutlet weak var resultDefinationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatePersonalityResulty()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
    }

    func calculatePersonalityResulty() {
        let frequencyOfAnswers = response.reduce(into: [:]){
            (counts, answer) in
            counts[answer.type, default: 0] += 1
        }
        let frequentAnswersSorted = frequencyOfAnswers.sorted(by: {(pair1, pair2) in
            return pair1.value > pair2.value })
        let mostCommonAnswer = frequentAnswersSorted.first!.key
        
        resultAnswerLabel.text = "You are a \(mostCommonAnswer.rawValue)"
        resultDefinationLabel.text = mostCommonAnswer.defination
 
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
