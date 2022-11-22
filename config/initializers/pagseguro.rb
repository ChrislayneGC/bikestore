PagSeguro.configure do |config|
    config.token       = "EB8333FDF2BB46BC80E602789C326349"
    config.email       = "helson.r.luciani@gmail.com"
    config.environment = :production # ou :sandbox. O padrão é production.
    config.encoding    = "UTF-8" # ou ISO-8859-1. O padrão é UTF-8.
end
  