import RxSwift
import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

Observable.of("Elon", "Stave", "Jeff", "Mark", "Jack").filter{ (value) in
    return value.starts(with: "J")
}.subscribe(onNext:{ (value) in
    print(value)
}).disposed(by: disposeBag)
