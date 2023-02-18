require 'rails_helper'

RSpec.describe Users::SignoutService do
  describe '.call' do
    context 'when the session is valid' do
      let(:session) { create(:session) }

      it 'returns no errors and success' do
        result = described_class.call(session:)

        expect(result.errors).to be_nil
        expect(result.success).to be(true)
        expect(session.reload).not_to be_active
      end
    end

    context 'when the session is invalid' do
      it 'returns errors and no success' do
        result = described_class.call(session: nil)

        expect(result.errors).to be_a(Array)
        expect(result.success).to be(false)
      end
    end
  end
end
