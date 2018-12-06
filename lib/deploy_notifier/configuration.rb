class DeployNotifier
  class Configuration
    attr_accessor :webhook, :project, :env

    def initialize
      @webhook = ''
      @project = 'local'
      @env = 'development'
    end
  end
end
