class ProjectConfigFile < ProjectFile

  def initialize(attributes = {})
    super
    @name = '_config'
  end

  # You dont want to change name and path of _config
  private :name=

end
