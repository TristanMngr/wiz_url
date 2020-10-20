class Link < ApplicationRecord
  has_many :link_clicks, dependent: :destroy

  def short
    Rails.application.routes.url_helpers.short_url(slug: slug)
  end
end
