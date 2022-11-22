class Banner < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>", large: "2048x856>"  }, path: 'public/images/banner_images/:naming_with_id.:extension'
  validates_attachment_content_type :image, content_type: ["image/jpeg", "image/gif", "image/png"]
  validates_attachment :image, presence: true

  scope :active, -> { where(active: true) }

  def self.active_image_url 
    @banners = Array.new
    Banner.active.all.each do |item|
      @banners.push(item.image.url(:large))
    end
    return @banners
  end
  
end
