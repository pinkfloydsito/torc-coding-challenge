
require './main'

describe Main do
    context 'sample input 1' do
        subject(:sample_1) do
          described_class.new(input: "2 book at 12.49\n1 music CD at 14.99\n1 chocolate bar at 0.85")
        end

        it 'should return the valid formatted total' do
            expect(subject.formatted_total).to eq "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32"
        end
    end

    context 'sample input 2' do
        subject(:sample_2) do
          described_class.new(input: "1 imported box of chocolates at 10.00\n1 imported bottle of perfume at 47.50")
        end

        it 'should return the valid formatted total' do
            expect(subject.formatted_total).to eq "1 imported box of chocolates: 10.50\n1 imported bottle of perfume: 54.65\nSales Taxes: 7.65\nTotal: 65.15"
        end
    end

    context 'sample input 3' do
        subject(:sample_3) do
          described_class.new(input: "1 imported bottle of perfume at 27.99\n1 bottle of perfume at 18.99\n1 packet of headache pills at 9.75\n3 imported boxes of chocolates at 11.25")
        end

        it 'should return the valid formatted total' do
            expect(subject.formatted_total).to eq "1 imported bottle of perfume: 32.19\n1 bottle of perfume: 20.89\n1 packet of headache pills: 9.75\n3 imported boxes of chocolates: 35.55\nSales Taxes: 7.90\nTotal: 98.38"
        end
    end
end