require 'rocket-chat-notifier'

class DeployNotifier
  attr_reader :project, :env, :hook
  private :project, :env, :hook

  def initialize(project: 'local', env: 'development', hook:)
    @project = project
    @env = env
    @hook = hook
  end

  def success_deploy
    notifier.ping(success_message)
  end

  def failure_deploy
    notifier.ping(failure_message)
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

  def last_git_log
    @last_git_log ||= `git log -1 --pretty='%an||%s'`.split('||').map(&:strip)
  end

  def author
    last_git_log.first
  end

  def commit_message
    last_git_log.last
  end

  def success_message
    "#{ author }: #{ commit_message }. Публикация прошла успешно"
  end

  def failure_message
    "#{ author }: #{ commit_message }. Ошибка публикации"
  end
end
