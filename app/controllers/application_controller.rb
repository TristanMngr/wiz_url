class ApplicationController < ActionController::Base

  private

  # Use this as a before filter to prevent caching for certain actions
  def prevent_browser_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = '0'
  end
end
