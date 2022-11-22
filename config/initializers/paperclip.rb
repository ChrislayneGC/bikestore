# config/initializers/paperclip.rb
if Rails.env.development? || Rails.env.test?
  
else
  Paperclip::Attachment.default_options[:s3_host_name] = 's3-sa-east-1.amazonaws.com'
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:convert_options] = { :all => '-layers merge' }
end


Paperclip.interpolates :char do |attachment, style|
  attachment.instance.name.downcase[0]
end

Paperclip.interpolates :hashid do |attachment, style|
  SecureRandom.hex
end

Paperclip.interpolates :naming do |attachment, style|
  attachment.instance.name.parameterize
end

Paperclip.interpolates :naming_with_id do |attachment, style|
  [attachment.instance.name, attachment.instance.id].join("-").parameterize
end
