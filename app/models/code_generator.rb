class CodeGenerator

  def self.generate
    SecureRandom.uuid.gsub(/-/i, '').first(10).upcase
  end

  def self.charge_credit_card
    # variable with merchant key
    merchantKey = '85328786-8BA6-420F-9948-5352F5A183EB'
    # instantiate class with request methods
    # :sandbox for sandbox ambient
    # :production for production ambient
    gateway = Gateway::Gateway.new(:sandbox, merchantKey)
    # create credit card transaction object
    creditCardTransaction = Gateway::CreditCardTransaction.new
    # 100 reais in cents
    creditCardTransaction.AmountInCents = 10000
    creditCardTransaction.Options.PaymentMethodCode = 1
    creditCardTransaction.CreditCard.CreditCardNumber = '4111111111111111'
    creditCardTransaction.CreditCard.ExpMonth = 10
    creditCardTransaction.CreditCard.ExpYear = 18
    creditCardTransaction.CreditCard.HolderName = 'LUKE SKYWALKER'
    creditCardTransaction.CreditCard.SecurityCode = '123'
    creditCardTransaction.CreditCard.CreditCardBrand = 'Visa'
    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)
  end

  def self.charge_billet
    # variable with merchant key
    merchantKey = '85328786-8BA6-420F-9948-5352F5A183EB'

    # instantiate class with request methods
    # :sandbox for sandbox ambient
    # :production for production ambient
    gateway = Gateway::Gateway.new(:sandbox, merchantKey)

    # creates boleto transaction object
    boletoTransaction = Gateway::BoletoTransaction.new

    # 100 reais in cents
    boletoTransaction.AmountInCents = 10000
    boletoTransaction.BankNumber = '237'

    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new

    # adds to the boleto transaction collection
    createSaleRequest.BoletoTransactionCollection << boletoTransaction

    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)
  end

end
