class Hash
  def keys_present? arr
    arr.each do |r|
      unless self.has_key? r
        return false
      end
    end
    true
  end
end