import RxSwift
import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

let formatter = NumberFormatter()
formatter.numberStyle = .spellOut

let observable = Observable<NSNumber>.of(123, 47, 9).map { (value) in
    formatter.string(from: value) ?? ""
}

let subscriber = observable.subscribe(onNext:{ (value) in
    print(value)
}).disposed(by: disposeBag)
