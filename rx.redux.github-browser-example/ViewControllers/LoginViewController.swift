//
//  ViewController.swift
//  rx.redux.github-browser-example
//
//  Created by Hung Dinh on 12/02/16.
//  Copyright © 2016 chucuoi.net. All rights reserved.
//

import UIKit
import RxRedux
import RxCocoa
import RxSwift
import PureLayout

final class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Authenticate with GitHub", comment: ""), for: .normal)
        view.addSubview(button)
        
        NSLayoutConstraint.autoCreateAndInstallConstraints {
            button.autoCenterInSuperview()
        }
        
        button.rx.tap.subscribe(onNext: {
            store.dispatch(AuthenticateActionCreator().authenticateUser())
        }).addDisposableTo(disposeBag)
    }
    
    private let disposeBag = DisposeBag()
}

