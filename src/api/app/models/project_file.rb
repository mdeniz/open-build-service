class ProjectFile < BackendFile

  attr_accessor :project_name

  validates :project_name, presence: true

  def full_path(params = {})
    query = params.blank? ? '' : "?#{params.to_query}"
    URI.encode("/source/#{project_name}/_project/#{name}") + query
  end

  # _project/_meta (using meta=1), _project/_pubkey (read and delete), _history (readonly), _project/_config are stored in /source/project/ folder...
end
