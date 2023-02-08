require './services/tax_service'

class Main

    attr_reader :input
    def initialize(input:)
        @input = input
    end

    def products
        input.split("\n").map {|line| product_from_str(line: line) }
    end
    
    def net_total
        products.reduce(0) { |sum, product| sum + product[:price] * product[:quantity] }.round(2)
    end

    def total_tax
        products.reduce(0) { |sum, product| sum + Services::TaxService.new(product: product[:product], quantity: product[:quantity], price: product[:price]).tax_rate }.round(2)
    end

    def total
        (total_tax + net_total).round(2)
    end

    def formatted_total
        result = ""
        products.each do |product|
            tax_rate = Services::TaxService.new(product: product[:product], quantity: product[:quantity], price: product[:price]).tax_rate
            result.concat("#{product[:quantity]} #{product[:product]}: #{'%.2f' % (product[:price] * product[:quantity].to_f + tax_rate)}\n")
        end

        result.concat("Sales Taxes: #{'%.2f' % total_tax}\n")
        result.concat("Total: #{total.round(2)}")

        result
    end

    def product_from_str(line:)
        quantity = 0.0
        price = 0.0
        name = ''

        at_split = line.split(' at ')
        price = at_split[1]

        quantity_name_idx = at_split[0].index(" ")

        quantity = at_split[0][0..quantity_name_idx].to_i
        name = at_split[0][quantity_name_idx..-1]

        {
            product: name.strip,
            quantity: quantity,
            price: price.to_f
        }
    end

end

def multi_gets all_text=""
  while (text = gets) != "\n"
    all_text << text
  end
  all_text
end

# input = multi_gets.chomp

# main = Main.new(input: input)
# main.formatted_total