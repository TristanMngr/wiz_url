class LinksController < ApplicationController
  before_action :set_link_by_slug, only: [:short]
  before_action :set_link_by_id, only: [:show, :destroy]

  before_action :link_form, only: [:create]

  def short
    return render 'errors/404', status: :not_found if @link.nil?

    @link.link_clicks.create!
    redirect_to @link.url
  end

  def show
    @graph_link_presenter = ::GraphLinkPresenter.new(link: @link, end_time: params[:end_time])
  end

  def index
    @links = Link.all.order(:created_at, :desc)
  end

  def destroy
    if @link.destroy
      render json: {
        success: true,
        link_id: params[:id],
        message: "Shorten link with slug #{@link.slug} deleted !"
      }, status: :ok
    else
      render json: {
        success: false,
        link_id: params[:id],
        message: "Unable to delete shorten link with slug #{@link.slug}"
      }
    end
  end

  def create
    if @link_form.submit
      render json: {
        success: true,
        partial: render_to_string(
          'homepages/_link_row',
          layout: false,
          locals: { link: @link_form.link }
        ),
        message: "Shorten link with slug #{@link_form.link.slug} created !" 
      }, status: :created
    else
      render json: {
        success: false,
        partial: render_to_string('shared/_list_errors', layout: false, locals: { errors: @link_form.errors[:url] })
      }
    end
  end

  private

  def set_link_by_slug
    @link ||= Link.find_by(slug: params[:slug])
  end

  def set_link_by_id
    @link ||= Link.find(params[:id])
  end

  def link_form
    @link_form ||= LinkForm.new(link_params)
  end

  def link_params
    params[:link_form].permit(:url)
  end
end
