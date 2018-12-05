require 'spec_helper'

describe DeployNotifier do
  let(:notifier) { described_class.new(hook: 'hook') }
  let(:rocket_chat_notifier_instance) { instance_double(RocketChat::Notifier) }

  before do
    allow(RocketChat::Notifier).to receive(:new).and_return(rocket_chat_notifier_instance)
    allow(rocket_chat_notifier_instance).to receive(:ping)
  end

  describe '#success_deploy' do
    let(:message) { 'Публикация прошла успешно' }

    it 'sends success report' do
      notifier.success_deploy

      expect(rocket_chat_notifier_instance).to have_received(:ping).with(message)
    end
  end

  describe '#failure_deploy' do
    context 'failure message' do
      let(:message) { 'Ошибка публикации' }

      it 'sends success report' do
        notifier.failure_deploy

        expect(rocket_chat_notifier_instance).to have_received(:ping).with(message)
      end
    end
  end
end
