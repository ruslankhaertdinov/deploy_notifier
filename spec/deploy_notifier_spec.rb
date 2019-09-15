require 'spec_helper'

describe DeployNotifier do
  let(:notifier) { described_class.new(success: success) }
  let(:rocket_chat_notifier_instance) { instance_double(RocketChat::Notifier) }

  before do
    allow(RocketChat::Notifier).to receive(:new).and_return(rocket_chat_notifier_instance)
    allow(rocket_chat_notifier_instance).to receive(:ping)
    allow_any_instance_of(DeployNotifier::Configuration).to receive(:env).and_return(env)
  end

  describe '#send_report' do
    context 'success' do
      let(:success) { true }
      let(:ping_params) do
        ['Статус: успешно', { icon_emoji: icon_emoji }]
      end

      context 'production' do
        let(:env) { 'production' }
        let(:icon_emoji) { ':ballot_box_with_check:' }

        it 'sends success report' do
          notifier.send_report

          expect(rocket_chat_notifier_instance).to have_received(:ping).with(*ping_params)
        end
      end

      context 'staging' do
        let(:env) { 'staging' }
        let(:icon_emoji) { ':white_check_mark:' }

        it 'sends success report' do
          notifier.send_report

          expect(rocket_chat_notifier_instance).to have_received(:ping).with(*ping_params)
        end
      end
    end

    context 'failure' do
      let(:success) { false }
      let(:env) { 'production' }

      let(:ping_params) do
        ['Статус: ошибка', { icon_emoji: ':negative_squared_cross_mark:' }]
      end

      it 'sends failure report' do
        notifier.send_report

        expect(rocket_chat_notifier_instance).to have_received(:ping).with(*ping_params)
      end
    end
  end
end
