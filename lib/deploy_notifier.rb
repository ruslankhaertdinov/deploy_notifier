require 'rocket-chat-notifier'
require 'deploy_notifier/configuration'

class DeployNotifier
  CHANNEL = 'project_publications'.freeze
  SUCCESS_ICON = ':white_check_mark:'.freeze
  FAILURE_ICON = ':negative_squared_cross_mark:'.freeze

  class << self
    def configuration
      @configuration ||= DeployNotifier::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  attr_reader :success
  private :success

  def initialize(success:)
    @success = success
  end

  def send_report
    notifier.ping(report_message, icon_emoji: icon_emoji)
  end

  private

  def notifier
    RocketChat::Notifier.new(webhook, channel: CHANNEL, username: username)
  end

  def username
    "Deploy: #{ project } | #{ env.capitalize }"
  end

  def report_message
    # временно отключил проверку гита
    # "#{ task_number }: #{ author } #{ commit_message }. Статус: #{ state_translation }"
    "Статус: #{ state_translation }"
  end

  def task_number
    number = `git rev-parse --abbrev-ref HEAD`.scan(/^\d+/).first
    number.nil? ? '<номер не указан>' : "##{ number }"
  end

  def author
    "<#{ last_git_log.first }>"
  end

  def commit_message
    last_git_log.last
  end

  def last_git_log
    @last_git_log ||= `git log -1 --pretty='%an||%s'`.split('||').map(&:strip)
  end

  def state_translation
    success? ? 'успешно' : 'ошибка'
  end

  def success?
    success == true
  end

  def icon_emoji
    success? ? SUCCESS_ICON : FAILURE_ICON
  end

  def method_missing(method, *args)
    if %i[webhook project env].include?(method)
      self.class.configuration.send(method)
    else
      super
    end
  end
end
