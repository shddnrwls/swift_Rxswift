//
//  ViewController.swift
//  RxSwiftBindingExample
//
//  Created by mac on 2018. 4. 20..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ChameleonFramework

class ViewController: UIViewController {

    var circleView: UIView!
    fileprivate var circleViewModel: CircleViewModel!
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        // 원 모양의 뷰를 그립니다
        circleView = UIView(frame: CGRect(origin: view.center, size: CGSize(width: 100.0, height: 100.0)))
        circleView.layer.cornerRadius = circleView.frame.width / 2.0
        circleView.center = view.center
        circleView.backgroundColor = .green
        view.addSubview(circleView)
        
        circleViewModel = CircleViewModel()
          // CircleView의 중앙 지점을 centerObservable에 묶습니다(Bind).
        circleView
            .rx.observe(CGPoint.self, "center")
            .bindTo(circleViewModel.centerVariable)
            .addDisposableTo(disposeBag)
        
        // ViewModel의 새로운 색을 얻기 위해 backgroundObservable을 구독(Subscribe)합니다.
        circleViewModel.backgroundColorObservable
            .subscribe(onNext:{ [weak self] backgroundColor in
                UIView.animate(withDuration: 0.1) {
                    self?.circleView.backgroundColor = backgroundColor
                     // 주어진 배경색의 상호 보완적인 색을 구합니다
                    let viewBackgroundColor = UIColor(complementaryFlatColorOf: backgroundColor)
                     // 새로운 배경색과 기존의 배경색이 다른지 검사합니다
                    if viewBackgroundColor != backgroundColor {
                        // 원의 배경색으로 새로운 배경색을 할당합니다
                        // 우린 그저 뷰에서의 원이 보일 수 있는 다른 색을 원합니다
                        self?.view.backgroundColor = viewBackgroundColor
                    }
                }
            })
            .addDisposableTo(disposeBag)
        
        // gesture recognizer를 추가합니다
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(circleMoved(_:)))
        circleView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func circleMoved(_ recognizer: UIPanGestureRecognizer) {
        let location = recognizer.location(in: view)
        UIView.animate(withDuration: 0.1) {
            self.circleView.center = location
        }
    }
    
}

