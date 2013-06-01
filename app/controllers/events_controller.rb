class EventsController < ApplicationController
  skip_before_filter :verify_authenticity_token

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
    end
  end
end
