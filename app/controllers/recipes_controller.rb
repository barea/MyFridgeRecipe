class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    #@recipes = Recipe.all
    @recipes = Recipe.accessible_by(current_ability)
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
     @recipe = Recipe.find(params[:id])
    @ingredients = @recipe.ingredients
  end
#search by ingredients
  def searchbyingt
     @ingredients = Ingredient.all
    if params[:ingredient_ids]      
        @recipes = Ingredient.where(id: params[:ingredient_ids]).map{ |ing| ing.recipes }.flatten.uniq
    else
        @recipes = Recipe.all
    end  
  end
  
#search by Recipe title 
  def searchbyrecipe 
    @recipes = if params[:title]
  	  Recipe.where('title like?', "%#{params[:title]}%")
    else
      Recipe.all
    end
  end

  # GET /recipes/new
  def new
   @recipe = Recipe.new
    @ingredients = Ingredient.all
  end

  # GET /recipes/1/edit
  def edit
    @ingredients = Ingredient.all
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    authorize! :create, @recipe

     params[:recipe][:ingredient_ids].each do |ingredient_id|
      unless ingredient_id.empty?
        ingredient = Ingredient.find(ingredient_id)
        @recipe.ingredients << ingredient
      end
    end

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    authorize! :update, @recipe
    params[:recipe][:ingredient_ids].each do |ingredient_id|
      unless ingredient_id.empty?
        ingredient = Ingredient.find(ingredient_id)
        @recipe.ingredients << ingredient
      end
    end
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    authorize! :destroy, @recipe
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:title, :prep, :preptime, :serving, :user_id)
    end
end
