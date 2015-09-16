class BackendFile

  include ActiveModel::Model

  attr_accessor :content, :name

  validates :name, presence: true

  def initialize(attributes={})
    super
    @content ||= nil
  end

  def content(query = {})
    @content = Suse::Backend.get(full_path(query)) if @content.nil? && valid?
    @content
  end

  def reload
    @content = nil
    content
  end

  def save
  end

  def delete
  end


end
