require 'spec_helper'

describe DeployNotifier do
  let(:notifier) { described_class.new(success: success) }
  let(:rocket_chat_notifier_instance) { instance_double(RocketChat::Notifier) }

  before do
    allow(RocketChat::Notifier).to receive(:new).and_return(rocket_chat_notifier_instance)
    allow(rocket_chat_notifier_instance).to receive(:ping)
  end

  describe '#send_report' do
    context 'success message' do
      let(:success) { true }
      let(:message) { 'Публикация прошла успешно' }

      it 'sends success report' do
        notifier.send_report

        expect(rocket_chat_notifier_instance).to have_received(:ping).with(message)
      end
    end

    context 'failure message' do
      let(:success) { false }
      let(:message) { 'Ошибка публикации' }

      it 'sends success report' do
        notifier.send_report

        expect(rocket_chat_notifier_instance).to have_received(:ping).with(message)
      end
    end
  end
end
