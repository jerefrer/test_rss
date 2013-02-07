class SharedController < ActionController::Base
	def index
		@fluxes = Flux.all
		@items = Item.all
	end
	
	def destroy
    @flux = Flux.find(params[:id])
    @flux.destroy
  end
  
  
  # GET /fluxes/new
  # GET /fluxes/new.json
  def new
    @flux = Flux.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @flux }
    end
  end
  
  # POST /fluxes
  # POST /fluxes.json
  def create
    @flux = Flux.new(params[:flux])

  ajoutRSS()
  
    respond_to do |format|
      if @flux.save
        format.html { redirect_to("http://localhost:3000") }
        format.json { render json: @flux, status: :created, location: @flux }
      else
        format.html { render action: "new" }
        format.json { render json: @flux.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # ajoutRSS
  private
  def ajoutRSS
  require 'rss'
  require 'open-uri'
  
  liens = Flux.all
  liens.each do |lien|
    open(lien.url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
      Item.create(:flux_id => lien.id, :titre => item.title, :contenu => item.description, :date =>item.pubDate, :status => 'non lu')
      end
    end
  end
  end
  
   def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
  
end
