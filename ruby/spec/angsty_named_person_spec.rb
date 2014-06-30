require 'spec_helper'

describe AngstyNamedPerson do
  subject { described_class.new(name, age) }

  context do
    let(:name) { 'Eduardo' }
    let(:age) { 23 }

    it 'Do not change property values' do
      subject.transactionally do |obj|
        obj.age = 20
        obj.name = 'Sparkles'
      end

      expect(subject.name).not_to eq 'Sparkles'
      expect(subject.age).not_to eq 20
    end

    it 'Change property values' do
      subject.transactionally do |obj|
        obj.age = 21
        obj.name = 'Matheus'
      end

      expect(subject.name).to eq 'Matheus'
      expect(subject.age).to eq 21
    end
  end
end
