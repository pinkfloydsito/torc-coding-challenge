# frozen_string_literal: true

module Services
  # Service used to calculate the tax rate for a given product
  # , depending on conditions such as the the type of product
  # and if it is imported or not
  class TaxService
    attr_reader :product, :quantity, :price

    def initialize(product:, quantity:, price:)
      @product = product
      @quantity = quantity
      @price = price
    end

    def tax_rate
      total = 0
      total += price * quantity * 0.10 unless book? || medicine? || food?

      ((import_duty + total) * 20).round.to_f / 20
    end

    def import_duty
      return price * quantity * 0.05 if imported?

      0
    end

    def book?
      %w[book books].any? { |keyword| product.downcase.include? keyword }
    end

    def medicine?
      %w[medicine pill].any? { |keyword| product.downcase.include? keyword }
    end

    def food?
      %w[chocolate food soup water].any? { |keyword| product.downcase.include? keyword }
    end

    def imported?
      product.downcase.include? 'imported'
    end
  end
end
