class Checkout
    def self.create(order_id)
      # O modo como você irá armazenar os produtos que estãoe sendo comprados
      # depende de você. Neste caso, temos um modelo Order que referência os
      # produtos que estão sendo comprados.
      order = Order.find(order_id)
      # Você também pode fazer o requespricet de pagamento usando credenciais
      # diferentes, como no exemplo abaixo
  
      #payment = PagSeguro::PaymentRequest.new(email: 'rodolphosnow@gmail.com', token: '4224DAA74FB9448E90FFC8DD8D8A9856')
      payment = PagSeguro::PaymentRequest.new
  
      payment.reference = order.id
      #payment.notification_url = notifications_url
      #payment.redirect_url = processing_url
  
      order.items.each do |order_item|
        quantity = order_item.quantity
        quantity.times do |i|
          payment.items << {
            id: order_item.item.id,
            description: order_item.item.name,
            amount: order_item.item.price,
            weight: order_item.item.weight.to_i
          }
        end
      end

      if order.shipping.present? && order.shipping.value.present?
        payment.items << {
          id: 123456,
          description: order.shipping.kind || "frete",
          amount: order.shipping.value,
          weight: 0
        }
      end
  
      # Caso você precise passar parâmetros para a api que ainda não foram
      # mapeados na gem, você pode fazer de maneira dinâmica utilizando um
      # simples hash.
      #payment.extra_params << { paramName: 'paramValue' }
      #payment.extra_params << { senderBirthDate: '07/05/1981' }
      #payment.extra_params << { extraAmount: '-15.00' }
  
      response = payment.register
      
  
      # Caso o processo de checkout tenha dado errado, lança uma exceção.
      # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
      # exception_notification poderá notificar sobre o ocorrido.
      #
      # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
      if response.errors.any?
        return false
      else
        return response
      end
      return response
    end
  end