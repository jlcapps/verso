class Hash
  def symbolize_nested_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = if self[key].is_a?(Hash)
        delete(key).symbolize_nested_keys!
      elsif self[key].is_a?(Array)
        delete(key).collect do |i|
          if i.is_a?(Hash)
            i.symbolize_nested_keys!
          end
          i
        end
      else
        delete(key)
      end
    end
    self
  end
end
