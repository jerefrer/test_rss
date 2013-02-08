class SharedController < ApplicationController

	def index
		@fluxes = Flux.all
		@items = Item.all
	end

end
