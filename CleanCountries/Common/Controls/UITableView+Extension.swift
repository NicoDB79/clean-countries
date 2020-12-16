//
//  UITableView+Extension.swift
//  CleanCountries
//
//  Created by Nicola De Bei on 14/12/2020.
//

import UIKit

extension UITableView {
    func setBottomInset(to value: CGFloat) {
        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)

        self.contentInset = edgeInset
        self.scrollIndicatorInsets = edgeInset
    }
}
