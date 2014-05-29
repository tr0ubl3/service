class EventCause < ActiveRecord::Base
  attr_accessible :cause

  belongs_to :service_event

  def self.tokens(query)
  	causes = where("cause like ?", "%#{query}%")
  	if causes.empty?
  		[{id: "<<<#{query}>>>", cause: "New \"#{query}\""}]
  	else
  		causes
  	end
  end

  def self.ids_from_tokens(tokens)
  	tokens.gsub!(/<<<(.+?)>>>/) { create!(cause: $1).id }
  	tokens.split(',')
  end
end
