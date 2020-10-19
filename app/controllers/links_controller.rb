class LinksController < ApplicationController
  before_action :set_link_by_slug, only: [:short]
  before_action :set_link_by_id, only: [:show]

  before_action :graph_link_presenter, only: [:show]
  before_action :link_form, only: [:create]

  def short
    # TODO change this line
    return render 'errors/404', status: 404 if @link.nil?

    @link.link_clicks.create!
    redirect_to @link.url
  end

  def show
  end

  def index
    @links = Link.all.order(:created_at, :desc)

    respond_to do |format|
      format.js
    end
  end

  def destroy
    Link.find(params[:id]).destroy
    render json: { link_id: params[:id] }
  end

  def create
    if @link_form.submit
      render json: { success: true, link_row_partial: render_to_string('homepages/_link_row', layout: false, locals: { link: @link_form.link }) }
    else
      render json: { success: false, form_errors_partial: render_to_string('homepages/_errors', layout: false, locals: { errors: @link_form.errors[:url] })  }
    end
  end

  private

  
  def set_link_by_slug
    @link ||= Link.find_by_slug(params[:slug])
  end

  def set_link_by_id
    @link ||= Link.find(params[:id])
  end

  def link_form
    @link_form ||= LinkForm.new(link_params)
  end

  def graph_link_presenter
    @graph_link_presenter ||= ::GraphLinkPresenter.new(link: @link)
  end

  def link_params
    params[:link_form].permit(:url)
  end
end
