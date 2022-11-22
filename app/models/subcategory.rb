class Subcategory < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  belongs_to :category
  has_many :items

  before_save :update_slug

  scope :active, -> { where(active: true)}

  def to_s
    name
  end

  private

  def update_slug
    self.slug = self.name.parameterize
  end
end
