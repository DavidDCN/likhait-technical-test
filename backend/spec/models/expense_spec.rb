require 'rails_helper'

RSpec.describe Expense, type: :model do
  let!(:food_category) { Category.create!(name: "Food") }

  describe "date validation" do
    it "is valid with today's date" do
      expense = Expense.new(
        description: "Lunch",
        amount: 10.00,
        category: food_category,
        date: Date.current
      )

      expect(expense).to be_valid
    end

    it "is valid with a past date" do
      expense = Expense.new(
        description: "Old lunch",
        amount: 10.00,
        category: food_category,
        date: 5.days.ago.to_date
      )

      expect(expense).to be_valid
    end

    it "is invalid with a future date" do
      expense = Expense.new(
        description: "Future lunch",
        amount: 10.00,
        category: food_category,
        date: 1.day.from_now.to_date
      )

      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("cannot be in the future")
    end

    it "is invalid without a date" do
      expense = Expense.new(
        description: "No date lunch",
        amount: 10.00,
        category: food_category,
        date: nil
      )

      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("can't be blank")
    end
  end
end
