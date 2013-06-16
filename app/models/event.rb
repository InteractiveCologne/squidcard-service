class Event < ActiveRecord::Base
  include HTTParty

  belongs_to :admin

  attr_accessible :key, :card_uid, :resource, :name, :url, :method, :format, :admin

  before_validation :create_event_key

  validates :key, presence: true, uniqueness: true
  validates :url, presence: true # No further URL-Checking. If someone messes that up, I guess he's doing it willingly ;)
  validates :method, presence: true, inclusion: { in: %w[get post put] }, allow_nil: true
  validates :format, presence: true, inclusion: { in: %w[json xml html] }, allow_nil: true
  validates :admin, presence: true

  def checkin(card_uid, resource)
    errors = {}

    # Load Card by UID
    card = YetAnotherKard.find_by_uid card_uid unless card_uid.nil?

    # Needs resource but does not have it
    errors[:resource] = 'Resource is required but missing.' if resource.nil? and self.resource
    # Needs Card but does not have it
    errors[:yak] = 'YetAnotherKard-UID is required but missing.' if card.nil? and self.card_uid

    errors[:method] = "Method #{self.method.upcase} does not match [GET POST]" unless [:get, :post].include? self.method.to_sym

    if errors.blank?
      options = {}

      # assemble Options
      options[:yak_uid] = card.uid if self.card_uid
      options[:resource] = resource if self.resource

      # Do call the Event-Service here
      begin

        logger.info "Calling URL: '#{self.url}' with '#{options}'"

        response = self.class.send(
          method.to_sym,
          self.url,
          {
            body: options,
            headers: {
              'ContentType' => 'application/json',
              'Accept' => 'application/json'
            }
          }
        )

        if response.code == 200
          parsed_response = JSON.parse(response.body).symbolize_keys


          if parsed_response[:success]
            parsed_response.delete(:success)
            result = parsed_response
          else
            result = {errors: parsed_response[:errors]}
          end
        else
          result = {errors: "Response from Webservice: #{response.code} - #{response.message}".strip}
        end
      rescue Errno::ECONNREFUSED => e
        result = {errors: "Connection to Webservice refused"}
      end
    else
      result = {errors: errors}
    end

    logger.info "Result: #{result}"


    return result
  end
  protected

  def create_event_key
    hash =  [('a'..'z'),('A'..'Z'),(0..9)].map{|i| i.to_a}.flatten
    while self.key.nil?
      key  =  (0...40).map{ hash[rand(hash.length)] }.join
      if Event.where(key: key).count == 0
        self.key = key
      end
    end
  end
end
