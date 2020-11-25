//
//  AddTaskViewController.swift
//  My Daily Tasks
//
//  Created by Skander Bahri on 25/11/2020.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {

    private let taskSubject = PublishSubject<Task>()
    
    var taskSubjectObservable : Observable<Task>{
        return taskSubject.asObservable()
    }
    
    @IBOutlet weak var taskSegment: UISegmentedControl!
    @IBOutlet weak var taskTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: Any) {
        guard
            let priority = Priority(rawValue: taskSegment.selectedSegmentIndex),
            let title = taskTextFiled.text
        else { return }
        
        let task = Task(title: title, priority: priority)
        taskSubject.onNext(task)
        self.dismiss(animated: true, completion: nil)
    }
}
