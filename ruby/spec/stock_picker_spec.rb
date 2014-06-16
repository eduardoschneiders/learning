require 'spec_helper'

describe '#stock_picker' do
  context do
    let(:prices) { [17, 3, 6, 9, 15, 8, 6, 1, 10] }

    it do
      days = stock_picker(prices)
      expect(days).to eql [1, 4]
    end
  end

  context do
    let(:prices) { [17, 3, 1, 9, 15, 8, 6, 101, 10] }

    it do
      days = stock_picker(prices)
      expect(days).to eql [2, 7]
    end
  end

end
