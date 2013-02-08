class ItemsController < ApplicationController
  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  def create
    @item = Item.new(params[:item])

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render action: "new" # Affiche la vue 'new' (ATTENTION: ne *redirige* pas vers l'action new mais affiche seulement sa vue)
    end
  end

  # PUT /items/1
  def update
    @item = Item.find(params[:id])

    if @item.update_attributes(params[:item])
      redirect_to @item
    else
      render action: "edit" # Affiche la vue 'edit' (ATTENTION: ne *redirige* pas vers l'action edit mais affiche seulement sa vue)
    end
  end

  # DELETE /items/1
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to items_path
  end

  # POST /items/1/mark_as
  def mark_as
    @item = Item.find(params[:id])
    params[:read] == "1" ? @item.read! : @item.unread!

    redirect_to root_path
  end
  
end
