class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :subcategories
  scope :active, -> { where(active: true)}

  before_save :update_slug


  def to_s
    name
  end

  def items
    _items = Array.new
    _highlights = Array.new
    subcategories.each do |subcategory|
      subcategory.items.active.each do |item|
        if item.highlight
          _highlights.push(item)
        else
          _items.push(item)
        end
      end
    end
    return _highlights + _items
  end


  private


  def update_slug
    self.slug = self.name.parameterize
  end

end
