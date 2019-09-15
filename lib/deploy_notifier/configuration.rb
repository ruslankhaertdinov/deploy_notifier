class DeployNotifier
  class Configuration
    attr_accessor :webhook, :project, :env, :success_icon_production, :success_icon_staging

    def initialize
      @webhook = ''
      @project = 'local'
      @env = 'development'
      @success_icon_production = ':ballot_box_with_check:'
      @success_icon_staging = ':white_check_mark:'
    end
  end
end
