require 'rocket-chat-notifier'

class DeployNotifier
  attr_reader :project, :env, :hook
  private :project, :env, :hook

  SUCCESS_MESSAGE = 'Публикация прошла успешно'.freeze
  FAILURE_MESSAGE = 'Ошибка публикации'.freeze

  def initialize(project: 'local', env: 'development', hook:)
    @project = project
    @env = env
    @hook = hook
  end

  def success_deploy
    notifier.ping(SUCCESS_MESSAGE)
  end

  def failure_deploy
    notifier.ping(FAILURE_MESSAGE)
  end

  private

  def notifier
    RocketChat::Notifier.new(hook, channel: channel, username: username)
  end

  def channel
    'project_publications'
  end

  def username
    "Deploy: #{ project } | #{ env.capitalize }"
  end
end
