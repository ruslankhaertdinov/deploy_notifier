class DeployNotifier
  class Configuration
    attr_accessor :project, :env

    def initialize
      @project = 'local'
      @env = 'development'
    end
  end
end
