class RecipeMailerPreview < ActionMailer::Preview
  def share
    recipe = Recipe.first || Recipe.new(title: "Sample Soup", description: "A warm bowl for practice drills.")
    RecipeMailer.share(recipe: recipe, recipient: "friend@example.com")
  end
end
