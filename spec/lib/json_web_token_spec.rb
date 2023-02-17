require 'rails_helper'

RSpec.describe JsonWebToken do
  let(:payload) { { token: 'abcd' } }
  let(:token) { described_class.encode(payload) }

  describe '#encode' do
    it 'returns a token' do
      expect(token).to be_a(String)
    end
  end

  describe '#decode' do
    context 'when the token is valid' do
      it 'returns the payload' do
        expect(described_class.decode(token)).to eq(payload)
      end
    end

    context 'when the token is invalid' do
      it 'returns nil' do
        expect(described_class.decode('invalid_token')).to be_nil
      end
    end
  end
end
