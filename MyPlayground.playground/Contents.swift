import Foundation

class VendingMachineProduct {
    var name: String
    var amount: Int
    var price: Double
    init(name: String, amount: Int, price: Double){
        self.name = name
        self.amount = amount
        self.price = price
    }
}

//TODO: Definir os erros
enum VendingMachineError: Error {
        case productNotFound
        case productUnavailable
        case insufficientMoney
        case productStuck
        case maquinaExplodiu
}

extension VendingMachineError: LocalizedError{
    var errorDescription: String?{
        switch self{
        case .productNotFound:
            return "acabou o produto"
        case .productUnavailable:
            return "produto indisponível"
        case .insufficientMoney:
            return "dinheiro insuficiente"
        case .productStuck:
            return "entalou"
        case .maquinaExplodiu:
            return "BOOOM!!!!"
        }
    }
}
class VendingMachine {
    
    private var estoque: [VendingMachineProduct]
    private var money:Double
    
    init(products: [VendingMachineProduct]) {
        self.estoque = products
        self.money = 0
    }
    
    func getProduct(named name: String, with money: Double) throws {
        //TODO: receber o dinheiro e salvar em uma variável
        self.money += money
        //TODO: achar o produto que o cliente quer
        let produtoOptional = estoque.first { (produto) -> Bool in
            return produto.name == name
        }
        guard let produto = produtoOptional else {
            throw VendingMachineError.productNotFound
        }
        //TODO: ver se ainda tem esse produto
        guard produto.amount > 0 else {throw VendingMachineError.productUnavailable}
        //TODO: ver se o dinheiro é o suficiente pro produto
        guard produto.price <= self.money else {
            throw VendingMachineError.insufficientMoney
        }
        self.money = self.money - produto.price
        produto.amount = produto.amount - 1
        //TODO: entregar o produto
        if Int.random(in: 0...100) < 10 {
            throw VendingMachineError.productStuck
        }
        if Int.random(in: 0...100)>90{
            throw VendingMachineError.maquinaExplodiu
        }
    }
    
    func getTroco() -> Double {
        var money = self.money
        self.money = 0.0
        //TODO: devolver o dinheiro que não foi gasto
        return 0
    }
}

let vendingMachine = VendingMachine(products: [VendingMachineProduct(name: "Carregador de iPhone", amount: 5, price: 150.00),
                                               VendingMachineProduct(name: "Cebolitos", amount: 2, price: 5.00),
                                               VendingMachineProduct(name: "Unbrella", amount: 5, price: 125.00)])

do{
    try vendingMachine.getProduct(named: "Unbrella", with: 130.0)
}catch{
    print(error.localizedDescription)
}


