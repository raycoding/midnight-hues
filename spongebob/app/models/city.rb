class City < Location
  validates_presence_of :city
  has_many :zip_codes, :foreign_key => :city, :primary_key => :city
  has_many :locations, :foreign_key => :city, :primary_key => :city

  def zip_search(zip_prefix, options={})
    scope = zip_codes
    scope = scope.where("zip LIKE '#{zip_prefix}%'") if zip_prefix.present?
    scope = scope.where(options)
    scope.select(:zip).distinct.map(&:zip)
  end
end