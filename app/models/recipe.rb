class Recipe < ApplicationRecord
  belongs_to :user, optional: true
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true
  validates :prep_time, numericality: { greater_than: 0 }, allow_nil: true
  validates :servings, numericality: { greater_than: 0 }, allow_nil: true
  validates_associated :ingredients, :steps
end
