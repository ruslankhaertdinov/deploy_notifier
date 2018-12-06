require 'spec_helper'

describe DeployNotifier do
  let(:notifier) { described_class.new(success: success) }
  let(:rocket_chat_notifier_instance) { instance_double(RocketChat::Notifier) }

  before do
    allow(RocketChat::Notifier).to receive(:new).and_return(rocket_chat_notifier_instance)
    allow(rocket_chat_notifier_instance).to receive(:ping)
  end

  describe '#send_report' do
    context 'success' do
      let(:success) { true }

      it 'sends success report' do
        notifier.send_report

        expect(rocket_chat_notifier_instance).to have_received(:ping)
      end
    end

    context 'failure' do
      let(:success) { false }

      it 'sends failure report' do
        notifier.send_report

        expect(rocket_chat_notifier_instance).to have_received(:ping)
      end
    end
  end
end
