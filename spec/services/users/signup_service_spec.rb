require 'rails_helper'

RSpec.describe Users::SignupService do
  describe '.call' do
    context 'when the user is valid' do
      let(:user) { build(:user) }

      it 'returns a user, a session and no errors' do
        result = described_class.call(
          username: user.username,
          email: user.email,
          password: user.password,
          name: user.name
        )

        expect(result.user).to be_a(User)
        expect(result.auth_token).to be_a(String)
        expect(result.errors).to be_nil
      end
    end

    context 'when the user is invalid' do
      let(:user) { build(:user, username: nil) }

      it 'returns no user, no session and errors' do
        result = described_class.call(
          username: user.username,
          email: user.email,
          password: user.password,
          name: user.name
        )

        expect(result.user).to be_nil
        expect(result.auth_token).to be_nil
        expect(result.errors).to be_a(Array)
      end
    end
  end
end
