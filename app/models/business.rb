class Business < ActiveRecord::Base
  #include Tenacity

  acts_as_taggable
  acts_as_commentable

  include PgSearch
  pg_search_scope :search, against: [:name, :description]

  attr_accessible :address, :name, :latitude, :longitude, :tag_list, :rating, :rating_count,
                  :description
  # :latitude and :longitude are necessary for geocoder to geocode the address
  geocoded_by :address
  # only geocode if the address changed
  after_validation :geocode, if: :address_changed?
  after_validation :update_location, if: :address_changed?


  set_rgeo_factory_for_column(:center, RGeo::Geographic.spherical_factory(:srid => 4326))
  private

  def update_location
    self.center = "POINT(#{self.longitude} #{self.latitude})"
  end

end
