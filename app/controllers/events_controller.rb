class EventsController < ApplicationController
  before_filter :authenticate_admin!, except: [:checkin, :activate]
  load_and_authorize_resource except: [:checkin, :activate]
  skip_before_filter :verify_authenticity_token, only: [:checkin, :activate]

  # Tell CanCan to use current_admin instead of current_user
  def current_ability
    @current_ability ||= ::Ability.new(current_admin)
  end

  def index
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
    kard = YetAnotherKard.find_by_uid params[:card_uid]

    unless event.nil? or kard.nil?
      send_response event.checkin(params[:card_uid], params[:resource])
    else
      errors = Hash.new

      # check if Event is valid
      errors[:yak] = "Event-Key is missing" if params[:event_key].nil?
      errors[:yak] = "Event-Key is not found" if event.nil? and params[:event_key].present?

      # check if Kard is valid
      errors[:event] = "Kard-Key is missing" if params[:card_uid].nil?
      errors[:event] = "Kard-Key is not found" if kard.nil? and params[:card_uid].present?

      send_response({errors: errors})
    end
  end

  def activate
    kard = YetAnotherKard.find_or_create_by_uid params[:card_uid]

    send_response{{kard: kard}}
  end

  protected

  def send_response(response)
    respond_to do |format|
      format.json do
        render :json => {success: (response[:errors].blank? ? :true : false)}.merge(response).to_json
      end
      format.xml do
        render :xml => {success: (response[:errors].blank? ? :true : false)}.merge(response).to_xml
      end
      format.html {render :file => 'public/404.html', :status => :not_found, :layout => false}
    end
  end
end
