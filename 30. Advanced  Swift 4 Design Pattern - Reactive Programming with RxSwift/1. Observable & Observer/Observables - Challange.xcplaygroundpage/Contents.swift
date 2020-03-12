import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true


let disposable = DisposeBag()

let observable = Observable.from([1,2,3,4])

let subscriber = observable.subscribe(onNext:{(value) in
    print(value)
}).disposed(by: disposable)
