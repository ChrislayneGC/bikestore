class ItemImage < ActiveRecord::Base
  belongs_to :item

  if Rails.env.eql?("development")
    has_attached_file :image, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", path: 'public/images/items_images/:naming_with_id.:extension'
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  else
    has_attached_file :image, styles: {original: ['480x340>', :jpg]}, path: '/images/items_images/:naming_with_id.:extension'
    validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
  end

  def s3_image
    if Rails.env.eql?("development")
      image.url
    else
      "https:#{image.url}"
    end
  end
  
end
