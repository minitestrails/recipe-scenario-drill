class RecipesController < ApplicationController
  allow_unauthenticated_access only: %i[ index show new create deliver_share ]
  before_action :set_recipe, only: %i[ show edit update destroy deliver_share ]
  before_action :authorize_recipe_owner!, only: %i[ edit update destroy ]

  def index
    @recipes = Recipe.includes(:user).order(created_at: :desc)
  end

  def show
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.steps.build(position: 1)
  end

  def edit
    @recipe.ingredients.build if @recipe.ingredients.empty?
    @recipe.steps.build(position: (@recipe.steps.maximum(:position) || 0) + 1) if @recipe.steps.empty?
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = Current.user if Current.user

    if @recipe.save
      redirect_to @recipe, notice: "Recipe was successfully created."
    else
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe, notice: "Recipe was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @recipe.destroy!
    redirect_to recipes_path, notice: "Recipe was successfully destroyed.", status: :see_other
  end

  def deliver_share
    recipient = params[:recipient_email].to_s.strip
    if recipient.blank?
      redirect_to @recipe, alert: "Please enter an email address."
      return
    end

    RecipeMailer.share(recipe: @recipe, recipient: recipient).deliver_now
    redirect_to @recipe, notice: "Recipe shared with #{recipient}."
  end

  private

    def set_recipe
      @recipe = Recipe.find(params.expect(:id))
    end

    def authorize_recipe_owner!
      return if @recipe.user_id.present? && @recipe.user_id == Current.user&.id

      redirect_to recipes_path, alert: "Not authorized"
    end

    def recipe_params
      params.expect(
        recipe: [
          :title,
          :description,
          :servings,
          :prep_time,
          ingredients_attributes: [ [ :id, :name, :quantity, :unit, :_destroy ] ],
          steps_attributes: [ [ :id, :position, :instruction, :_destroy ] ]
        ]
      )
    end
end
