
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
end