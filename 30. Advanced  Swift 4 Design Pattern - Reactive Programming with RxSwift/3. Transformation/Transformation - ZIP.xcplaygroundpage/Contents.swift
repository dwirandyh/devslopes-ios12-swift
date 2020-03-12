import RxSwift
import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

let disposeBag = DisposeBag()

let carMakes = Observable.of("Deloran", "Bugatti", "Lotus", "Chevrolet")
let carModels = Observable.of("DMC-12", "Veyron", "Elise", "Suburban")

Observable.zip(carMakes, carModels){ (make, model) in
    return make + " - " + model
}.subscribe(onNext:{ (result) in
    print(result)
}).disposed(by: disposeBag)
