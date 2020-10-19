class LinkForm
  include ActiveModel::Model

  attr_accessor :url

  attr_reader :link

  validates_presence_of :url, message: "You should add an url"
  validate :ensure_correct_format
  validates_length_of :url, within: 3..255, on: :create, message: "The url is to long"

  def submit
    if valid?
      @link = Link.create!(url: url, slug: generate_slug)
      true
    else
      false
    end
  end

  def ensure_correct_format
    if url.scan(URI::regexp(%w[http https])).empty?
      errors.add(:url, "It is a not a valid url")
    end
  end

  def generate_slug
    loop do
      new_slug = SecureRandom.uuid[0..5]
      break new_slug unless Link.find_by(slug: new_slug)
    end
  end
end