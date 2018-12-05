require 'rocket-chat-notifier'

class DeployNotifier
  attr_reader :success, :project, :env
  private :success, :project, :env

  def initialize(success:, project: 'local', env: 'development')
    @success = success
    @project = project
    @env = env
  end

  def send_report
    notifier.ping(message)
  end

  private

  def notifier
    RocketChat::Notifier.new(webhook, channel: channel, username: username)
  end

  def webhook
    ENV['ROCKET_CHAT_DEPLOY_WEBHOOK']
  end

  def channel
    'project_publications'
  end

  def username
    "Deploy: #{ project } | #{ env.capitalize }"
  end

  def message
    if success == true
      'Публикация прошла успешно'
    else
      'Ошибка публикации'
    end
  end
end
