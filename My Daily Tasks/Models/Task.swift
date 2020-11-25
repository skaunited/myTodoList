//
//  Task.swift
//  My Daily Tasks
//
//  Created by Skander Bahri on 25/11/2020.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low 
}


struct Task {
    let title : String
    let priority : Priority
}
