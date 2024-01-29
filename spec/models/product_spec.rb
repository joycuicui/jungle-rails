require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "Validations" do
    let(:category) { Category.create(name: "Some-Plant") }

    let(:product_attributes) do
      {
        name: "A big tree",
        price: 77.99,
        quantity: 7,
        category: category
      }
    end

    let(:product) { Product.new(product_attributes)}
    
    it "saves successfully with all four fields set" do
      expect(product).to be_valid
    end
    
    it "requires a name" do
      product.name = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end
    
    it "requires a price" do
      product.price = nil
      product.price_cents = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end
   
    it "requires a quantity" do
      product.quantity = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it "requires a category" do
      product.category = nil
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  
  end
end
