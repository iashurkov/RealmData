//
//  ViewOutput.swift
//  RealmData
//
//  Created by iashurkov on 11.07.2022.
//

import UIKit

protocol ViewOutput: AnyObject {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDeinit()
    func viewWillChangeOrientation(to orientation: UIDeviceOrientation)
    func viewDidChangeOrientation(to orientation: UIDeviceOrientation)
}

extension ViewOutput {
    func viewDidLoad() { }
    func viewWillAppear() { }
    func viewDidAppear() { }
    func viewWillDisappear() { }
    func viewDeinit() { }
    func viewWillChangeOrientation(to orientation: UIDeviceOrientation) { }
    func viewDidChangeOrientation(to orientation: UIDeviceOrientation) { }
}
