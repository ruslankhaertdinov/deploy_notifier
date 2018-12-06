require 'rocket-chat-notifier'
require 'deploy_notifier/configuration'

class DeployNotifier
  class << self
    def configuration
      @configuration ||= DeployNotifier::Configuration.new
    end

    def configure
      yield(configuration)
    end
  end

  def success_deploy
    notifier.ping(report_message('успешно'), icon_emoji: ':white_check_mark:')
  end

  def failure_deploy
    notifier.ping(report_message('ошибка'), icon_emoji: ':negative_squared_cross_mark:')
  end

  private

  def notifier
    RocketChat::Notifier.new(webhook, channel: channel, username: username)
  end

  def channel
    # 'project_publications'
    'finsup_notifications_test'
  end

  def username
    "Deploy: #{ project } | #{ env.capitalize }"
  end

  def report_message(state)
    "#{ task_number }: #{ author } #{ commit_message }. Статус: #{ state }"
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

  def method_missing(method, *args)
    if %i[webhook project env].include?(method)
      self.class.configuration.send(method)
    else
      super
    end
  end
end
