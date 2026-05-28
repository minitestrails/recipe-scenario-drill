class RecipeMailer < ApplicationMailer
  def share(recipe:, recipient:)
    @recipe = recipe
    @recipe_url = recipe_url(@recipe)

    mail(
      to: recipient,
      subject: "Recipe: #{@recipe.title}"
    )
  end
end
