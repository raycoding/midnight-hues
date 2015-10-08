class State < Location
  validates_presence_of :state
  [:locations, :districts, :cities, :zip_codes].each do |association|
    has_many association, :foreign_key => :state, :primary_key => :state
  end

  def district_names(country='',state='')
    locations.where(:country => country,:state => state).where("district is NOT NULL").select(:district).distinct.map(&:district)
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