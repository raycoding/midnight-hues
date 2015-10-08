class ZipCode < Location
  validates_presence_of :zip
  include LatLongFinder
  def zips(country='', state='', district='', city='')
    if (country.blank? || country.downcase == self.country.downcase) &&
        (state.blank? || state.downcase == self.state.downcase) &&
          (district.blank? || district.downcase == self.district.downcase) &&
            (city.blank? || city.downcase == self.city.downcase)
      [zip]
    else
      []
    end
  end

  def zip_search(zip_prefix = '', options={})
    if self.zip.begins_with?(zip_prefix)
      [self.zip]
    else
      []
    end
  end

  def update_latitude_lontitude
    address = "#{self.city}, #{self.district}, #{self.state}, #{self.country.upcase}, #{self.zip}"
    puts address
    result = find_latitude_longtide address
    if !result.blank?
      self.latitude,self.longtitude = result
      self.ll_source = 'google'
      self.save
    end
  end
end
