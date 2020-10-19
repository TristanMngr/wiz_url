module HomepagesHelper
  def display_shorten_url_for(host:, slug:)
    "#{host}/#{slug}" 
  end
end
