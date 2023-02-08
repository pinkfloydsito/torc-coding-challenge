module Services
  class TaxService
    attr_reader :product, :quantity, :price

    def initialize(product:, quantity:, price:)
      @product = product
      @quantity = quantity
      @price = price
    end

    def tax_rate
      total = 0
      unless book? || medicine? || food?
        total += price * quantity * 0.10
      end

      import_duty + total
    end

    def import_duty
      if imported?
        return price * quantity * 0.05
      end

      0
    end

    def book?
      ['book', 'books'].any? { |keyword| product.downcase.include? keyword }
    end

    def medicine?
      ['medicine', 'pill'].any? { |keyword| product.downcase.include? keyword }
    end

    def food?
      ['chocolate', 'food', 'soup', 'water'].any? { |keyword| product.downcase.include? keyword }
    end

    def imported?
      product.downcase.include? "imported" 
    end
  end
end
