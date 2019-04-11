//
//  UIBarButtonItem.swift
//  medanswer
//
//  Created by Santiago Bustamante on 12/17/18.
//  Copyright © 2018 MedAnswers. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(withImage image: UIImage?, color: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        let but: UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        but.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        but.backgroundColor = UIColor.clear

        if let color = color {
            but.setImage(image?.image(withTintColor: color), for: .normal)
        }

        if let action = action {
            but.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        }
        but.sizeToFit()

        self.init(customView: but)
    }

    convenience init(withTitle title: String?, textColor: UIColor? = nil, target: Any? = nil, action: Selector? = nil) {
        let but: UIButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        but.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        but.backgroundColor = UIColor.clear
        but.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        if let textColor = textColor {
            but.setTitleColor(textColor, for: .normal)
        }
        but.setTitle(title, for: .normal)
        if let action = action {
            but.addTarget(target, action: action, for: UIControl.Event.touchUpInside)
        }
        but.sizeToFit()

        self.init(customView: but)
    }
}
