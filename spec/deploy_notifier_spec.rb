require 'spec_helper'

describe DeployNotifier do
  let(:notifier) { described_class.new }
  let(:rocket_chat_notifier_instance) { instance_double(RocketChat::Notifier) }

  before do
    allow(RocketChat::Notifier).to receive(:new).and_return(rocket_chat_notifier_instance)
    allow(rocket_chat_notifier_instance).to receive(:ping)
  end

  describe '#success_deploy' do
    it 'sends success report' do
      notifier.success_deploy

      expect(rocket_chat_notifier_instance).to have_received(:ping)
    end
  end

  describe '#failure_deploy' do
    context 'failure message' do
      it 'sends success report' do
        notifier.failure_deploy

        expect(rocket_chat_notifier_instance).to have_received(:ping)
      end
    end
  end
end
