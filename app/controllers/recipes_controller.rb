class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  protect_from_forgery with: :null_session

  # GET /recipes or /recipes.json
  def index
    current_uri = request.env['PATH_INFO']

    @recipes = if current_uri == '/recipes'
                 Recipe.all
               else
                 Recipe.where('public = true').order('created_at DESC')
               end
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @foods = Food.all
    @recipe = Recipe.find(params[:id])
    @recipe_food = RecipeFood.new
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(user: current_user,
                         name: params[:recipe][:name],
                         preparation_time: params[:recipe][:preparation_time],
                         cooking_time: params[:recipe][:cooking_time],
                         description: params[:recipe][:description],
                         public: params[:recipe][:public])

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_ingredient
    food = Food.find(params[:food])
    @recipe = Recipe.find(params[:recipe])
    @recipe_food = RecipeFood.new(food: food, recipe: @recipe, quantity: params[:recipe_food][:quantity])

    respond_to do |format|
      if @recipe_food.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Ingredient was successfully added to recipe.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        @foods = Food.all
        @food_recipe = @recipe.recipe_foods.new
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @recipe_food.errors, status: :unprocessable_entity }
      end
    end
  end

  def shopping_list
    @shopping_list = Recipe.includes(:recipe_foods).find(params[:recipe_id])
  end

  private

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.fetch(:recipe, {}).permit(:name, :description, :public, :preparation_time, :cooking_time)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
