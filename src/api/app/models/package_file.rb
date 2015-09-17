class PackageFile < BackendFile

  attr_accessor :project_name, :package_name

  validates :project_name, :package_name, presence: true

  def full_path(params = {})
    query = params.blank? ? '' : "?#{params.to_query}"
    URI.encode("/source/#{project_name}/#{package_name}/#{name}") + query
  end
end
