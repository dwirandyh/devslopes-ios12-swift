import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

public struct Person {
  public var car: BehaviorSubject<String>
  
  public init(car: BehaviorSubject<String>) {
    self.car = car
  }
}

let disposeBag = DisposeBag()

let persons = PublishSubject<Person>()

persons
  .flatMap {
    $0.car
  }
  .subscribe(onNext: {
    print($0)
  })
  .disposed(by: disposeBag)

let john = Person(car: BehaviorSubject(value: "Toyota Corolla"))

persons.onNext(john)

let alice = Person(car: BehaviorSubject(value: "Honda Accord"))

persons.onNext(alice)

john.car.onNext("Ford Model T")

// Output:
// Toyota Corolla
// Honda Accord
// Ford Model T
