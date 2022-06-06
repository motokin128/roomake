class NumberOfImagesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    total_number_of_images = record.post.photos.length + number_of_images_to_add(value) - number_of_images_to_delete(record)
    record.errors.add attribute, (options[:message] || 'は最大6枚まで選択できます') if total_number_of_images > 6 || total_number_of_images.zero?
  end

  def number_of_images_to_add(value)
    value.nil? ? 0 : value.length
  end

  def number_of_images_to_delete(record)
    record.delete_ids.nil? ? 0 : record.delete_ids.length
  end
end
