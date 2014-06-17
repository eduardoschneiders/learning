require 'spec_helper'

describe '#substrings' do
  context do
    let(:dictionary_words)  { ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit'] }
    let(:phrase)            { "Howdy below, go eit down! How's it going?" }
    let(:matches)           { {:below=>1, :down=>1, :go=>2, :going=>1, :how=>2, :howdy=>1, :it=>2, :i=>3, :low=>1, :own=>1 } }

    it 'success' do
      result = substrings(phrase, dictionary_words)
      expect(result).to eql matches
    end
  end


  context do
    let(:dictionary_words)  { ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit'] }
    let(:phrase)            { "Howdy below, go eit down! How's it going?" }
    let(:matches)           { {:below=>2, :down=>2, :go=>3, :going=>2, :how=>2, :howdy=>1, :it=>2, :i=>3, :low=>1, :own=>1 } }

    it 'fails' do
      result = substrings(phrase, dictionary_words)
      expect(result).not_to eql matches
    end
  end
end
