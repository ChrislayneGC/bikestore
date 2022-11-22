class Item < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :subcategory
  has_many :images, class_name: "ItemImage"

  validates :subcategory, presence: true
	validates :weight, numericality: {greater_than: 0.001}, presence: true
	validates :width, presence: true, numericality: {greater_than: 16, less_than: 105}
	validates :height, presence: true, numericality: {greater_than: 2, less_than: 105}
	validates :length, presence: true, numericality: {greater_than: 11, less_than: 105}

  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  before_save :update_slug

  scope :active, -> { where('active is true AND quantity > 0') }
  scope :highlight, -> { where('active is true AND highlight is true AND quantity > 0') }

  if Rails.env.eql?("development") 
    has_attached_file :image, styles: { medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png", path: 'public/images/items/:naming_with_id.:extension'
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  else
    has_attached_file :image, styles: {original: ['480x340>', :jpg]}, path: '/images/items/:naming_with_id.:extension'
    validates_attachment :image, content_type: { content_type: ['image/jpg', 'image/jpeg', 'image/png'] }
  end

  def to_s
    name
  end

  def image_path

  end
  
  def self.search(params)
    term = "%#{params}%"
    where('name ILIKE ?', term)
  end

  def s3_image
    if Rails.env.eql?("development")
      image.url
    else
      "https:#{image.url}"
    end
  end

  private

  def update_slug
    self.slug = self.name.parameterize
  end

end
