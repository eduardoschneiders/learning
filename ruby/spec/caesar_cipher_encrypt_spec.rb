require 'spec_helper'

describe 'Caesar' do
  it 'equals' do
    string = 'Eduardo Schneiders'
    encrypted_string = caesar_cipher(string, 5)
    decrypted_string = caesar_cipher(encrypted_string, 5, false)

    expect(decrypted_string).to eql string
  end

  it 'different' do
    string = 'Eduardo Schneiders'
    encrypted_string = caesar_cipher(string, 5)
    decrypted_string = caesar_cipher(encrypted_string, 15, false)

    expect(decrypted_string).not_to eql string
  end

end
