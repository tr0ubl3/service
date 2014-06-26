class EventCause < ActiveRecord::Base
  attr_accessible :name

  has_many :manifestations
  has_many :events, class_name: 'ServiceEvent', through: :manifestations

  def self.tokens(query)
  	causes = select('id, name, category, problem').where("name like ?", "%#{query}%")
  	if causes.empty?
  		[{id: "<<<#{query}>>>", name: "New \"#{query}\""}]
  	else
  		causes.each do |cause|
        cause.name = cause.name + ' (' + cause.problem + ')' unless cause.problem.nil?
      end
      return causes
  	end
  end

  def self.ids_from_tokens(tokens)
  	tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
  	tokens.split(',')
  end
end