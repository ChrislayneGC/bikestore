class Address < ActiveRecord::Base

  belongs_to :user
  geocoded_by :zipcode
  after_validation :geocode

  validates :street, :zipcode, :city, :state, :district, :number, presence: true

  scope :shipping, ->{ where(kind: 'shipping') }

  def to_s
    address
  end

  def address
    [street, number, district, city, state, country, complement].compact.join(', ')
  end

  def location
    [city, state].join(', ')
  end

  def self.search(params)
    return nil unless params[:zipcode].present?
    begin
      addr = BuscaEndereco.cep(params[:zipcode])
      { street: [addr[:tipo_logradouro], addr[:logradouro]].compact.join(' '), district: addr[:bairro], city: addr[:cidade], state: addr[:uf], zipcode: addr[:cep], complete: [[addr[:tipo_logradouro], addr[:logradouro]].compact.join(' '), addr[:bairro], addr[:cidade], addr[:uf]].compact.join(', ') }
    rescue => e
      nil
    end
  end

  def kind_br
    KIND.key(kind).present? ? KIND.key(kind) : KIND.key("shipping")
  end

  def to_api
    { id: id, kind: kind, address: address, location: location, zipcode: zipcode, longitude: longitude, latitude: latitude, complement: complement }
  end

  def to_order_info
    {id: id, kind: kind_br, street: street, number: number, district: district, city: city, state: state, zipcode: zipcode, complete: address, complement: complement}
  end

  def to_hash
    { kind: kind, street: street, city: city, state: state, district: district, number: number, zipcode: zipcode, longitude: longitude, latitude: latitude, complement: complement }
  end

  KIND = {
    "Casa" => "home",
    "Trabalho" => "work",
    "Endereço de Entrega" => "shipping"
  }

  STATES = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO"
  ]


end
