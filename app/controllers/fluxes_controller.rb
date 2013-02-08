class FluxesController < ApplicationController
  # GET /fluxes
  def index
    @fluxes = Flux.all
  end

  # GET /fluxes/1
  def show
    @flux = Flux.find(params[:id])
  end

  # GET /fluxes/new
  def new
    @flux = Flux.new
  end

  # GET /fluxes/1/edit
  def edit
    @flux = Flux.find(params[:id])
  end

  # POST /fluxes
  def create
    @flux = Flux.new(params[:flux])

    if @flux.save
      redirect_to root_path
    else
      render action: "new" # Affiche la vue 'new' (ATTENTION: ne *redirige* pas vers l'action new mais affiche seulement sa vue)
    end
  end

  # PUT /fluxes/1
  def update
    @flux = Flux.find(params[:id])

    if @flux.update_attributes(params[:flux])
      redirect_to @flux, notice: 'Flux was successfully updated.'
    else
      render action: "edit" # Affiche la vue 'edit' (ATTENTION: ne *redirige* pas vers l'action edit mais affiche seulement sa vue)
    end
  end

  # DELETE /fluxes/1
  def destroy
    @flux = Flux.find(params[:id])
    @flux.destroy

    respond_to do |format|
      format.html { redirect_to("http://localhost:3000")}
      format.json { head :no_content }
      format.js   { render :nothing => true }
    end
  end

end
