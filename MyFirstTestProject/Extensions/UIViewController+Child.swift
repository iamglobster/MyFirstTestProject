//
//  UIViewController+Child.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 03.09.2022.
//

import UIKit

extension UIViewController {

    func addChild(_ child: UIViewController, toContainer container: UIView) {

        addChild(child)

        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        child.view.frame = container.bounds
        container.addSubview(child.view)

        child.didMove(toParent: self)
    }
}
