import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

        var behaviorSubject = BehaviorSubject(value: "Value A")
        behaviorSubject.onNext("Value B")

        let subscriptionOne = behaviorSubject.subscribe(onNext:{ value in
            print("Subscription 1: \(value)")
        })

        behaviorSubject.onNext("Value C")
        behaviorSubject.onNext("Value D")

        let subscriptionTwo = behaviorSubject.subscribe(onNext:{ value in
            print("Subscription 2: \(value)")
        })

        behaviorSubject.onNext("Both subscriptions get this value.")

        // Final Result
        //Subscription 1: Value B
        //Subscription 1: Value C
        //Subscription 1: Value D
        //Subscription 2: Value D
        //Subscription 1: Both subscriptions get this value.
        //Subscription 2: Both subscriptions get this value.
