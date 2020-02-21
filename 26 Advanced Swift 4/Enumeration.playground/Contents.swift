        import UIKit

        enum NameOfEnum {
            case caseOne, caseTwo, caseThree
        }

        let enumeration: NameOfEnum = .caseOne

        enum Barcode {
            case upc(Int, Int, Int, Int)
            case qrCode(String)
        }

        var productBarcode = Barcode.upc(8, 85909, 51226, 3)

        productBarcode = Barcode.qrCode("dsadasdsa")

        switch productBarcode {
            case let .upc(numberSystem, manufacturer, productCode, check):
                print("UPC: \(numberSystem), \(manufacturer), \(productCode), \(check)")
            case let .qrCode(productCode):
                print("QR CODE: \(productCode)")
        }

        enum JediMaster : String {
            case yoda = "Yoda"
            case maceWindu = "Mace Windu"
            case quiGonJinn = "Qui-Gon Jinn"
            case obiWanKenobi = "Obi-Wan Kenobi"
            case lukeSkywalker = "Luke Skywalker"
        }

        print(JediMaster.yoda.rawValue)

        enum SwitchStatus {
            case on
            case off
        }

        var switchStatus : SwitchStatus = .on

        func flipSwitch(status: SwitchStatus) -> SwitchStatus {
            if status == .off {
                return .on
            }else {
                return .off
            }
        }

        flipSwitch(status: switchStatus)

        switchStatus = .on

        flipSwitch(status: switchStatus)
