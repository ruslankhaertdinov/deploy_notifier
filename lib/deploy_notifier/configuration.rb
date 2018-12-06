class DeployNotifier::Configuration
  attr_accessor :webhook, :project, :env

  def initialize
    @webhook = ''
    @project = 'local'
    @env = 'development'
  end
end
