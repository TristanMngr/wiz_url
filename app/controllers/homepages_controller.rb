class HomepagesController < ApplicationController
  before_action :link_form, only: [:index]
  before_action :prevent_browser_caching, only: [:index]

  def index
    @links = Link.order(created_at: :desc)
  end

  def link_form
    @link_form ||= LinkForm.new
  end
end
