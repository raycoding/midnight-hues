class CaseInsensitiveHash < Hash
  def [](key)
    super convert_key(key)
  end

  def []=(key, value)
    @original_keys ||= Set.new
    @original_keys << key
    super(convert_key(key), value)
  end

  def keys
    @original_keys.to_a
  end

  protected

    def convert_key(key)
      key.respond_to?(:upcase) ? key.upcase : key
    end
end