class Tag < ActiveRecord::Base
	has_one :blog

	def self.find_tags
  		Tag.limit(12).all().collect { |tag| [tag.tag_name, tag.id] }
	end  
end
