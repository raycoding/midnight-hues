class Location < ActiveRecord::Base
  before_save :clear_cache

  def clear_cache
    Rails.cache.delete("locations_distinct_country_names")
    Rails.cache.delete("locations_distinct_state_names")
    Rails.cache.delete("locations_distinct_district_state_names")
    Rails.cache.delete("locations_distinct_city_district_state_names")
    Rails.cache.delete("locations_distinct_city_state_names")
    Rails.cache.delete("locations_distinct_zips")
    Rails.cache.delete("locations_distinct_state_names")
  end

  def self.is_intrastate zip1, zip2
    s1 = ZipCode.find_by_zip(zip1)
    s2 = ZipCode.find_by_zip(zip2)
    s1.present? && s2.present? && s1.state.downcase.strip == s2.state.downcase.strip
  end

  def self.country_names
    all_distinct_country_names = Rails.cache.fetch("locations_distinct_country_names", :expires_in=>7.days) do
      where("country is NOT NULL").select(:country).distinct.map(&:country)
    end
    all_distinct_country_names
  end

  def self.state_names(country='')
    all_distinct_state_names = Rails.cache.fetch("locations_distinct_state_names", :expires_in=>7.days) do
      scope = where("state is NOT NULL")
      scope = scope.where("country = '#{country}'") if country.present?
      scope.select(:state).distinct.map(&:state)
    end
    all_distinct_state_names
  end

  def self.district_names(country='')
    all_distinct_state_names = Rails.cache.fetch("locations_distinct_district_state_names", :expires_in=>7.days) do
      scope = where("district is NOT NULL")
      scope = scope.where("country = '#{country}'") if country.present?
      scope.select(:district,:state).distinct.map(&:state)
    end
    all_distinct_state_names
  end

  def self.city_names(country='')
    all_distinct_city_state_names = Rails.cache.fetch("locations_distinct_city_state_names", :expires_in=>7.days) do
      scope = where("city is NOT NULL")
      scope = scope.where("country = '#{country}'") if country.present?
      scope.select(:city,:state).distinct
    end
    all_distinct_city_state_names
  end

  def self.city_names_with_district(country='')
    all_distinct_city_district_state_names = Rails.cache.fetch("locations_distinct_city_district_state_names", :expires_in=>7.days) do
      scope = where("city is NOT NULL")
      scope = scope.where("country = '#{country}'") if country.present?
      scope.select(:city,:district,:state).distinct
    end
    all_distinct_city_district_state_names
  end

  def self.zips
    all_distinct_zips = Rails.cache.fetch("locations_distinct_zips", :expires_in=>7.days) do
      scope = where("zip is NOT NULL")
      scope.select(:zip).distinct.map(&:zip)
    end
    all_distinct_zips
  end

  def country_names
    [self.country]
  end

  def state_names(country='')
    if country.blank? || self.country.downcase == country.downcase
      [state]
    else
      []
    end
  end

  def district_names(country='', state='')
    if (country.blank? || country.downcase == self.country.downcase) &&
        (state.blank? || state.downcase == self.state.downcase)
      [district]
    else
      []
    end
  end

  def city_names(country='', state='',district='')
    if (country.blank? || country.downcase == self.country.downcase) &&
        (state.blank? || state.downcase == self.state.downcase) && 
          (district.blank? || district.downcase == self.district.downcase)
      [city]
    else
      []
    end
  end

  def city_names_in_state(country='', state='')
    if (country.blank? || country.downcase == self.country.downcase) &&
        (state.blank? || state.downcase == self.state.downcase)
      [city]
    else
      []
    end
  end

  def zips(country='', state='', district='', city='')
    locations.where(:country => country, :state => state, :district=> district, :city => city).where("zip is NOT NULL").select(:zip).distinct.map(&:zip)
  end

  def self.get_location_ids_map_from_zip zip
    arr = []
    zip_array = ZipCode.find_all_by_zip(zip)
    zip_array.each do |zip_obj|
      city_obj = City.find_by_city(zip_obj.city)
      district_obj = District.find_by_district(zip_obj.district)
      state_obj = State.find_by_state(zip_obj.state)
      country_obj = Country.find_by_country(zip_obj.country)
      arr << zip_obj.id
      arr << city_obj.id if city_obj.present?
      arr << district_obj.id if district_obj.present?
      arr << state_obj.id if state_obj.present?
      arr << country_obj.id if country_obj.present?
    end
    arr
  end

  def self.get_locations_from_zip_city_state zip, city, district, state
    result_arr = Rails.cache.fetch("l_zip_city_district_state_#{zip.to_s.parameterize}_#{city.to_s.parameterize}_#{district.to_s.parameterize}_#{state.to_s.parameterize}", :expires_in=>12.hours) do
      arr = []
      arr += ZipCode.find_all_by_zip(zip)
      arr += City.find_all_by_city((arr.map { |i| i.city.to_s.downcase if i.city} + (city.nil? ? [] : [city.downcase])).uniq)
      arr += District.find_all_by_district((arr.map { |i| i.district.to_s.downcase if i.district} + (district.nil? ? [] : [district.downcase])).uniq)
      arr += State.find_all_by_state((arr.map { |i| i.state.to_s.downcase if i.state} + (state.nil? ? [] : [state.downcase])).uniq)
      arr += Country.find_all_by_country(arr.map(&:country).uniq)
      arr
    end
    result_arr
  end

  def self.get_locations_from_city query_city
    arr=[]
    arr+= City.find_all_by_city(query_city)
  end
end