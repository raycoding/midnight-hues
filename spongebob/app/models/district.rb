class District < Location
  validates_presence_of :state
  [:locations, :cities, :zip_codes].each do |association|
    has_many association, :foreign_key => :state, :primary_key => :state
  end

  def city_names(country='', state='', district = '')
    locations.where(:country => country,:state => state, :district => district).where("city is NOT NULL").select(:city).distinct.map(&:city)
  end

  def zip_search(zip_prefix, options={})
    scope = zip_codes
    scope = scope.where("zip LIKE '#{zip_prefix}%'") if zip_prefix.present?
    scope = scope.where(options)
    scope.select(:zip).distinct.map(&:zip)
  end
end