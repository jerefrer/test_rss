class Flux < ActiveRecord::Base
	has_many :items, :dependent => :destroy
	
	validates :titre, :url, :presence => { :message => "n'est pas rempli." }
	
	
end
