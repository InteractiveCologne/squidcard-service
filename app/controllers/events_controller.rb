class EventsController < ApplicationController
  before_filter :authenticate_admin!, except: :checkin
  load_and_authorize_resource except: :checkin
  skip_before_filter :verify_authenticity_token, only: :checkin

  # Tell CanCan to use current_admin instead of current_user
  def current_ability
    @current_ability ||= ::Ability.new(current_admin)
  end

  def index
    Rails.logger.debug @events.inspect
  end

  def show
  end

  def new
  end

  def create
    @event.admin = current_admin
    if @event.save
      redirect_to :events
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update_attributes params[:event]
      redirect_to :events
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to :events
  end

  def checkin
    event = Event.find_by_key params[:event_key] unless params[:event_key].nil?

    unless event.nil?
      send_response event.checkin(params[:card_uid], params[:resource])
    else
      errors = Hash.new

      # check if Event is valid
      errors[:event] = "Event-Key is missing" if params[:event_key].nil?
      errors[:event] = "Event-Key is incorrect" if event.nil? and params[:event_key].present?

      send_response({errors: errors})
    end
  end

  protected

  def send_response(response)
    respond_to do |format|
      format.json do
        render :json => {result: (response[:errors].blank? ? true : false), response: response}.to_json
      end
      format.xml do
        render :xml => {result: (response[:errors].blank? ? true : false), response: response}.to_xml
      end
      format.html {render :file => 'public/404.html', :status => :not_found, :layout => false}
    end
  end
end
