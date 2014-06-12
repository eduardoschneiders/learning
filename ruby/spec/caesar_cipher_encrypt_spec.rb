require 'spec_helper'

describe 'Caesar' do
  let(:string) { 'Eduardo Schneiders' }

  it 'equals' do
    encrypted_string = caesar_cipher(string, 5)
    decrypted_string = caesar_cipher(encrypted_string, 5, false)

    expect(decrypted_string).to eql string
  end

  it 'different' do
    encrypted_string = caesar_cipher(string, 5)
    decrypted_string = caesar_cipher(encrypted_string, 15, false)

    expect(decrypted_string).not_to eql string
  end

end
