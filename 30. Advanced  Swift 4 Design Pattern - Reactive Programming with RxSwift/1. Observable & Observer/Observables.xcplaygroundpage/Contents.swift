import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

let numberSequence = Observable.just(5)
let numberSubscription = numberSequence.subscribe(onNext: { (value) in
    print(value)
}).disposed(by: disposeBag)

let helloSequence = Observable.from(["H", "E", "L", "L", "O"])
let helloSubscription = helloSequence.subscribe(onNext: { (value) in
    print(value)
}, onError: { (error) in
    print(error)
}, onCompleted: {
    print("Complete")
}).disposed(by: disposeBag)
