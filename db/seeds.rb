alice = User.find_or_create_by!(email_address: "alice@example.com") do |user|
  user.password = "password123"
end

bob = User.find_or_create_by!(email_address: "bob@example.com") do |user|
  user.password = "password123"
end

unless Recipe.exists?
  Recipe.create!(
    title: "Tomato Soup",
    description: "A simple soup for practice drills.",
    servings: 4,
    prep_time: 15,
    user: alice,
    ingredients_attributes: [
      { name: "Salt", quantity: "1", unit: "pinch" }
    ],
    steps_attributes: [
      { position: 1, instruction: "Preheat oven to 350°F." },
      { position: 2, instruction: "Simmer tomatoes for 20 minutes." }
    ]
  )

  Recipe.create!(
    title: "Bob's Salad",
    description: "Owned by Bob for authorization drills.",
    servings: 2,
    prep_time: 10,
    user: bob,
    ingredients_attributes: [
      { name: "Lettuce", quantity: "2", unit: "cups" }
    ],
    steps_attributes: [
      { position: 1, instruction: "Wash and chop lettuce." }
    ]
  )
end
