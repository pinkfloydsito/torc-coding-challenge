# frozen_string_literal: true

require './services/tax_service'

# Class used to parse lines sent from STDIN and calculate its taxes using the tax_service
class Main
  attr_reader :input

  def initialize(input:)
    @input = input
  end

  def products
    input.split("\n").map { |line| product_from_str(line: line) }
  end

  def net_total
    products.reduce(0) { |sum, product| sum + product[:price] * product[:quantity] }.round(2)
  end

  def total_tax
    products.reduce(0) do |sum, product|
      sum + Services::TaxService.new(product: product[:product], quantity: product[:quantity],
                                     price: product[:price]).tax_rate
    end.round(2)
  end

  def total
    (total_tax + net_total).round(2)
  end

  def formatted_total
    result = +''
    products.each do |product|
      result.concat(formatted_product(product: product))
    end

    result.concat(format("Sales Taxes: %.2f\n", total_tax))
    result.concat(format('Total: %.2f', total.round(2)))

    result
  end

  def formatted_product(product:)
    tax_rate = Services::TaxService.new(product: product[:product], quantity: product[:quantity],
                                        price: product[:price]).tax_rate
    result = "#{product[:quantity]} "
    price_with_taxes = product[:price] * product[:quantity] + tax_rate

    result.concat(format("%<name>s: %<price>.2f\n", name: product[:product], price: price_with_taxes))
  end

  def product_from_str(line:)
    at_split = line.split(' at ')
    price = at_split[1]

    quantity_name_idx = at_split[0].index(' ')

    quantity = at_split[0][0..quantity_name_idx].to_i
    name = at_split[0][quantity_name_idx..]

    {
      product: name.strip,
      quantity: quantity,
      price: price.to_f
    }
  end
end

# rubocop:disable Style/NestedModifier
def multi_gets(all_text = +'')
  return all_text if all_text["\n\n"] while all_text << $stdin.gets
end
# rubocop:enable Style/NestedModifier

args = ARGV
return if args.empty? || args.first != 'run'

input = multi_gets.chomp

main = Main.new(input: input)
print main.formatted_total
