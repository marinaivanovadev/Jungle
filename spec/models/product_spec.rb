require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'saves successfully with all four fields set' do
      category = Category.create(name: 'Trees')
      product = Product.new(
        name: 'Void Fennel',
        price: 9.99,
        quantity: 9,
        category: category
      )
      expect(product.save).to be_truthy
    end

    it 'validates name presence true' do
      category = Category.create(name: 'Trees')
      product = Product.new(
        price: 79.99,
        quantity: 9,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'validates price presence true' do
      category = Category.create(name: 'Trees')
      product = Product.new(
        name: 'Void Fennel',
        quantity: 9,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'validates quantity presence true' do
      category = Category.create(name: 'Trees')
      product = Product.new(
        name: 'Void Fennel',
        price: 79.99,
        category: category
      )
      product.save
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    
    it 'validates category presence true' do
      product = Product.new(
        name: 'Void Fennel',
        price: 79.99,
        quantity: 9
      )
      product.save
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
