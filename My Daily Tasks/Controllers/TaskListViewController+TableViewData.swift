//
//  TaskListViewController+TableViewData.swift
//  My Daily Tasks
//
//  Created by Skander Bahri on 25/11/2020.
//

import UIKit

extension TaskListViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListViewCell", for: indexPath) as? TaskListViewCell else { return UITableViewCell() }
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
    
    
}
