require './services/tax_service'

describe Services::TaxService do
  context "when the product is a medicine" do
    subject(:tax_service_medicine) do
      described_class.new(product: "headache pill", price: 10, quantity: 1)
    end

    it 'should not apply tax rate' do 
      expect(subject.tax_rate).to eq(0)
    end
  end

  context "when the product is a book" do
    subject(:tax_service_book) do
      described_class.new(product: "book", price: 10, quantity: 1)
    end

    it 'should not apply tax rate' do 
      expect(subject.tax_rate).to eq(0)
    end
  end

  context "when the product is a chocolate" do
    subject(:tax_service_food) do
      described_class.new(product: "chocolate", price: 10, quantity: 1)
    end

    it 'should not apply tax rate' do 
      expect(subject.tax_rate).to eq(0)
    end
  end

  context "when the product is not a book, food or medicine" do
    subject(:tax_service_food) do
      described_class.new(product: "random product", price: 10, quantity: 1)
    end

    it 'should apply tax rate' do 
      expect(subject.tax_rate).to eq(1)
    end
  end

  context "when the product is imported" do
    subject(:tax_service_food) do
      described_class.new(product: "imported random product", price: 10, quantity: 1)
    end

    it 'should apply an additional tax of 5%' do 
      expect(subject.import_duty).to eq(0.5)
      expect(subject.tax_rate).to eq(1.5)
    end
  end

  context 'when the product is not imported' do
    subject(:tax_service_food) do
      described_class.new(product: "random product", price: 10, quantity: 1)
    end

    it 'should not apply an additional tax of 5%' do 
      expect(subject.import_duty).to eq(0)
      expect(subject.tax_rate).to eq(1)
    end
  end
end

