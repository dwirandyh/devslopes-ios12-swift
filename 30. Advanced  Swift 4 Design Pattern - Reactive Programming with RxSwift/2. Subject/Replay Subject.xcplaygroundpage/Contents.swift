import RxSwift
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

        var accountSubject = ReplaySubject<Double>.create(bufferSize: 3)

        accountSubject.onNext(10.15)

        var accountManager = accountSubject.subscribe(onNext:{
            print("Account Manager: Transaction amount: $\($0)")
        })

        accountSubject.onNext(12.49)
        accountSubject.onNext(299.00)
        accountSubject.onNext(15.00)
        accountSubject.onNext(80.0)
        accountSubject.onNext(74.12)
        accountSubject.onNext(100)

        print("\n")

        var lastThreeTransactions = accountSubject.subscribe(onNext:{
            print("Last three: Transaction amount:$\($0)")
        })

        // Final Output
        //Account Manager: Transaction amount: $10.15
        //Account Manager: Transaction amount: $12.49
        //Account Manager: Transaction amount: $299.0
        //Account Manager: Transaction amount: $15.0
        //Account Manager: Transaction amount: $80.0
        //Account Manager: Transaction amount: $74.12
        //Account Manager: Transaction amount: $100.0
        //
        //
        //Last three: Transaction amount:$80.0
        //Last three: Transaction amount:$74.12
        //Last three: Transaction amount:$100.0
