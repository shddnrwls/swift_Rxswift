//
//  CircleViewModel.swift
//  RxSwiftBindingExample
//
//  Created by mac on 2018. 4. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import Foundation
import ChameleonFramework
import RxSwift
import RxCocoa



class CircleViewModel {
    
    var centerVariable = Variable<CGPoint?>(.zero) // Create one variable that will be changed and observed
    var backgroundColorObservable: Observable<UIColor>! // Create observable that will change backgroundColor based on center
    
    init() {
        setup()
    }
    
    func setup() {
    // 새로운 중앙 값을 받으면, 새로운 UIColor를 반환합니다
    backgroundColorObservable = centerVariable.asObservable()
    .map { center in
    guard let center = center else { return UIColor.flatten(.black)() }
    
    let red: CGFloat = ((center.x + center.y).truncatingRemainder(dividingBy: 255.0)) / 255.0
    let green: CGFloat = 0.0
    let blue: CGFloat = 0.0
    
    return UIColor.flatten(UIColor(red: red, green: green, blue: blue, alpha: 1.0))()
    }
    }
}
