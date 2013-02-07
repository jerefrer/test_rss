class FluxesController < ApplicationController
  # GET /fluxes
  # GET /fluxes.json
  def index
    @fluxes = Flux.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @fluxes }
    end
  end

  # GET /fluxes/1
  # GET /fluxes/1.json
  def show
    @flux = Flux.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @flux }
    end
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

  # GET /fluxes/1/edit
  def edit
    @flux = Flux.find(params[:id])
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

  # PUT /fluxes/1
  # PUT /fluxes/1.json
  def update
    @flux = Flux.find(params[:id])

    respond_to do |format|
      if @flux.update_attributes(params[:flux])
        format.html { redirect_to @flux, notice: 'Flux was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @flux.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fluxes/1
  # DELETE /fluxes/1.json
  def destroy
    @flux = Flux.find(params[:id])
    @flux.destroy

    respond_to do |format|
      format.html { redirect_to("http://localhost:3000")}
      format.json { head :no_content }
      format.js   { render :nothing => true }
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
  
  
end
