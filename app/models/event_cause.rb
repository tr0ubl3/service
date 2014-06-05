class EventCause < ActiveRecord::Base
  attr_accessible :name

  belongs_to :service_event

  def self.tokens(query)
  	causes = select('id, name').where("name like ?", "%#{query}%")
  	if causes.empty?
  		[{id: "<<<#{query}>>>", name: "New \"#{query}\""}]
  	else
  		causes
  	end
  end

  def self.ids_from_tokens(tokens)
  	tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  	tokens.split(',')
  end
end
