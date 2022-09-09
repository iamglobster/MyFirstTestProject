//
//  UINavigationBarAppearance.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 06.09.2022.
//

import Foundation
import UIKit

enum UINavigationBarAppearanceType {
    case defaultAppear
    case opaque
    case transparent

    var backImage: UIImage {
        return UIImage(named: "backArrow")!
    }
}

extension UIViewController {
    private func customNavBarAppearance(
        _ type: UINavigationBarAppearanceType,
        titleColor: UIColor = .black,
        largeTitleColor: UIColor = .black,
        buttonColor: UIColor = .black,
        fontTitle: UIFont = UIFont.systemFont(ofSize: 20),
        backButtonText: String = ""
    ) -> UINavigationBarAppearance {
        let customNavBarAppearance = UINavigationBarAppearance()

        // set type nav bar
        switch type {
        case .defaultAppear:
            customNavBarAppearance.configureWithDefaultBackground()
            customNavBarAppearance.backgroundColor = .yellow
        case .opaque:
            customNavBarAppearance.configureWithOpaqueBackground()
            customNavBarAppearance.backgroundColor = .yellow
        case .transparent:
            customNavBarAppearance.configureWithTransparentBackground()
        }

        // Apply colored, font normal and large titles.
        customNavBarAppearance.titleTextAttributes = [
            .foregroundColor: titleColor,
            .font: fontTitle
        ]
        customNavBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: largeTitleColor
        ]

        // Apply white color to all the nav bar buttons.
        let barButtonItemAppearance = UIBarButtonItemAppearance(style: .plain)
        barButtonItemAppearance.normal.titleTextAttributes = [.foregroundColor: buttonColor]
        barButtonItemAppearance.disabled.titleTextAttributes = [.foregroundColor: UIColor.lightText]
        barButtonItemAppearance.highlighted.titleTextAttributes = [.foregroundColor: UIColor.label]
        barButtonItemAppearance.focused.titleTextAttributes = [.foregroundColor: buttonColor]

        customNavBarAppearance.buttonAppearance = barButtonItemAppearance
        customNavBarAppearance.backButtonAppearance = barButtonItemAppearance
        customNavBarAppearance.doneButtonAppearance = barButtonItemAppearance

        // change text with back button
        navigationController?.navigationBar.topItem?.title = backButtonText

        return customNavBarAppearance
    }

    func setNavigationStackCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        navigationController!.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController!.navigationBar.compactAppearance = newAppearance
        navigationController!.navigationBar.standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            navigationController!.navigationBar.compactScrollEdgeAppearance = newAppearance
        }
    }

    func setUIAppearanceCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        UINavigationBar.appearance().scrollEdgeAppearance = newAppearance
        UINavigationBar.appearance().compactAppearance = newAppearance
        UINavigationBar.appearance().standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            UINavigationBar.appearance().compactScrollEdgeAppearance = newAppearance
        }
    }


    func setLocalCustomNavBar(type: UINavigationBarAppearanceType) {
        let newAppearance = customNavBarAppearance(type)

        navigationItem.scrollEdgeAppearance = newAppearance
        navigationItem.compactAppearance = newAppearance
        navigationItem.standardAppearance = newAppearance

        if #available(iOS 15.0, *) {
            navigationItem.compactScrollEdgeAppearance = newAppearance
        }
    }
}
