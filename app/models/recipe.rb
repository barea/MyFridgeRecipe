class Recipe < ApplicationRecord
	has_and_belongs_to_many :ingredients

	validates_presence_of :title
	validates_presence_of :prep
	validates_presence_of :preptime
	validates_presence_of :serving
	validates_presence_of :chef_id

end
