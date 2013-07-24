class Location
  include Mongoid::Document
  #include Tenacity

  field :address, type: String
  field :name, type: String
  field :loc, type: Array

  index({ loc: "2d" }, { min: -200, max: 200 })


  #t_belongs_to :businesses
end
