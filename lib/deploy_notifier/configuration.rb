class DeployNotifier
  class Configuration
    attr_accessor :webhook, :project, :env

    def initialize
      @weebhook = ''
      @project = 'local'
      @env = 'development'
    end
  end
end
