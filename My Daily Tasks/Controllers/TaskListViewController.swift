//
//  TaskListViewController.swift
//  My Daily Tasks
//
//  Created by Skander Bahri on 25/11/2020.
//

import UIKit
import RxSwift
import RxCocoa


class TaskListViewController: UIViewController {

    @IBOutlet weak var prioritySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var tasks = BehaviorRelay<[Task]>(value: [])
    var filteredTasks = [Task]()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskViewController
        else { fatalError("Controller not found...") }
        addTVC.taskSubjectObservable
            .subscribe(onNext: { [weak self] task in
                guard let prioritySegment = self?.prioritySegment else { return }
                let priority = Priority(rawValue: prioritySegment.selectedSegmentIndex - 1)
                var currentTasks = self?.tasks.value
                currentTasks?.append(task)
                if let currentTasks = currentTasks{
                    self?.tasks.accept(currentTasks)
                    self?.filterTasks(by: priority)
                }
            }).disposed(by: disposeBag)
    }

    @IBAction func priorityValueChanged(segmentedControl : UISegmentedControl){
        let priority = Priority(rawValue:  segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    private func filterTasks(by priority : Priority?){
        if let priority = priority {
            self.tasks.map{ tasks in
                return tasks.filter{ $0.priority == priority }
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }else {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        }
    }
    
    private func updateTableView(){
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
        }
    }
}
