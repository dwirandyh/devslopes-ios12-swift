//
//  ViewController.swift
//  rxnamer
//
//  Created by Dwi Randy Herdinanto on 29/02/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameEntryTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameLabels: UILabel!
    
    var namesArray : [String] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        bindSubmitButton()
    }
    
    func bind(){
        nameEntryTextField.rx.text
            .map { (result) in
                if result == "" {
                    return "Type your name below."
                }else {
                    return "Hello, \(result!)"
                }
        }.bind(to: helloLabel.rx.text).disposed(by: self.disposeBag)
    }
    
    func bindSubmitButton(){
        submitButton.rx.tap.subscribe(onNext: {
            if self.nameEntryTextField.text != "" {
                self.namesArray.append(self.nameEntryTextField.text!)
                self.nameLabels.rx.text.onNext(self.namesArray.joined(separator: ", "))
                self.nameEntryTextField.rx.text.onNext("")
                self.helloLabel.rx.text.onNext("Type your name below.")
            }
        }).disposed(by: disposeBag)
    }
}

