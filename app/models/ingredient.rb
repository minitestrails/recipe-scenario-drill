class Ingredient < ApplicationRecord
  belongs_to :recipe

  validates :name, presence: true
  validates :quantity, presence: true
  validate :quantity_must_be_positive

  private

    def quantity_must_be_positive
      return if quantity.blank?

      value = Float(quantity)
      errors.add(:quantity, "must be greater than 0") if value.negative?
    rescue ArgumentError, TypeError
      errors.add(:quantity, "must be a number greater than 0")
    end
end
