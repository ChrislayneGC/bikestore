

class MundiPagg

  def self.charge_credit_card(order_total, card)
    # variable with merchant key
    merchantKey = '3dc51fe8-e272-4226-84f3-5f58b2b96254'
    # instantiate class with request methods
    # :sandbox for sandbox ambient
    # :production for production ambient
    gateway = Gateway::Gateway.new(:sandbox, merchantKey)
    # create credit card transaction object
    creditCardTransaction = Gateway::CreditCardTransaction.new
    # 100 reais in cents
    creditCardTransaction.AmountInCents = order_total
    creditCardTransaction.CreditCard.CreditCardNumber = card[:number]
    creditCardTransaction.CreditCard.ExpMonth = card[:exp_month]
    creditCardTransaction.CreditCard.ExpYear = card[:exp_year]
    creditCardTransaction.CreditCard.HolderName = card[:holder]
    creditCardTransaction.CreditCard.SecurityCode = card[:cvv]
    creditCardTransaction.CreditCard.CreditCardBrand = card[:brand]
    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new
    createSaleRequest.CreditCardTransactionCollection << creditCardTransaction
    raise createSaleRequest.inspect
    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)
  end

  def self.charge_billet(customer, order, shipping)
    total = (order.total_with_shipping * 100).to_i
    # variable with merchant key
    merchantKey = '3dc51fe8-e272-4226-84f3-5f58b2b96254'
    # instantiate class with request methods
    # :sandbox for sandbox ambient
    # :production for production ambient
    gateway = Gateway::Gateway.new(:sandbox, merchantKey)
    # creates boleto transaction object
    boletoTransaction = Gateway::BoletoTransaction.new
    # 100 reais in cents
    boletoTransaction.AmountInCents = total
    boletoTransaction.BankNumber = '237'
    # creates request object for transaction creation
    createSaleRequest = Gateway::CreateSaleRequest.new
    # adds to the boleto transaction collection
    createSaleRequest.BoletoTransactionCollection << boletoTransaction
    # make the request and returns a response hash
    response = gateway.CreateSale(createSaleRequest)
    if response["ErrorReport"] == nil && response["BoletoTransactionResultCollection"][0]["Success"] == true
      billet_url = response["BoletoTransactionResultCollection"][0]["BoletoUrl"]
      reference = response["OrderResult"]["OrderReference"]
      order = order.generate_billet(billet_url, reference)
      return {status: true, order: order}
    else
      return {status: false, order: order}
    end
  end
end
