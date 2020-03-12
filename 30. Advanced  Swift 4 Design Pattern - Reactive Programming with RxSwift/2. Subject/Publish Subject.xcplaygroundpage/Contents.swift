import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

        var publishSubject = PublishSubject<String>()

        publishSubject.onNext("Hello")
        publishSubject.onNext("World")

        let pubSubscription = publishSubject.subscribe(onNext: { (value) in
            print(value)
            // this method will be called three times to print My Name, Is Randy and Both subscription
        })

        publishSubject.onNext("My Name")
        publishSubject.onNext("Is Randy")


        let pubSubscriptionTwo = publishSubject.subscribe(onNext: { (value) in
            print(value)
            // this method will be called one times to print Both Subscription will get this message
        })

        publishSubject.onNext("Both subscription will get this message")

        // Final Result
        //My Name
        //Is Randy
        //Both subscription will get this message
        //Both subscription will get this message

