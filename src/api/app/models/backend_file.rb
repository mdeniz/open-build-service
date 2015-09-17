class BackendFile

  include ActiveModel::Model

  attr_accessor :content, :name

  validates :name, presence: true

  validate :transport_errors

  def initialize(attributes = {})
    super
    @content ||= nil
  end

  def content(query = {})
    # TODO
    # We need to take forward_from_backend into account to use it for the API
    begin
      @content = Suse::Backend.get(full_path(query)).body if @content.nil? && valid?
    rescue ActiveXML::Transport => e
      @transport_error = e.message
    end
    @content
  end

  def reload
    @content = nil
    content
  end

  def save(query)
    # TODO
    # This works only for put
    # We probably need some smart method to differ between PUT and POST
    # if request.form_data?
    #   response = Suse::Backend.post( path, '', { 'Content-Type' => 'application/x-www-form-urlencoded' } )
    # end
    # response = Suse::Backend.post( path, file )
    # The other code is basically the same ...

    # Download file
    file = Tempfile.new 'volley', encoding: 'ascii-8bit'
    buffer = String.new
    file.write(buffer) while content(query).read(40960, buffer)
    file.close
    file.open

    # pass to backend
    response = Suse::Backend.put(full_path(query), file)
    file.close!
    response
  end

  def delete(query)
    Suse::Backend.delete(full_path(query))
  end

  private

  def transport_errors
    unless @transport_error.blank?
      errors.add(:content, @transport_error)
    end
  end
end
