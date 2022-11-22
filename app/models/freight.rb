require 'correios-frete'
class Freight

  def self.calculate(destiny, origin, weight, width, height, length)
    if width.to_i < 11
      width = 12
    end
    if length.to_i < 16
      length = 16
    end
    freight = Correios::Frete::Calculador.new(cep_origem: origin,
                                        cep_destino: destiny,
                                        peso: weight,
                                        comprimento: length,
                                        largura: width,
                                        altura: height)
    servicos = freight.calcular :sedex, :pac
    return servicos
  end

  def self.calculate_sedex
    options = Freight.calculate
    return options[:sedex]
  end

  def self.calculate_pac
    options = Freight.calculate
    return options[:pac]
  end

  def self.teste
    frete = Correios::Frete::Calculador.new(:cep_origem => "04094-050",
                                        :cep_destino => "90619-900",
                                        :peso => 0.3,
                                        :comprimento => 30,
                                        :largura => 15,
                                        :altura => 2)

    servicos = frete.calcular :sedex, :pac

    # servicos[:sedex].nome          # => "SEDEX"
    # servicos[:sedex].descricao     # => "SEDEX sem contrato"
    # servicos[:sedex].valor         # => 26.2
    # servicos[:sedex].prazo_entrega # => 1
    #
    # servicos[:pac].nome          # => "PAC"
    # servicos[:pac].descricao     # => "PAC sem contrato"
    # servicos[:pac].valor         # => 10.0
    # servicos[:pac].prazo_entrega # => 5
    return servicos

  end



end
