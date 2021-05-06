class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :check_notifications, :check_messages_notifications

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :photo])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :photo])
  end

  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end

  def check_notifications
    return if current_user.nil?

    @my_swap_requests = Swap.where(user_id: current_user.id, notify_requester: true)
    @my_products_swaps = Swap.joins(:product).where("products.user_id = ?", current_user.id) & Swap.where(notify_owner: true)
    @should_notify_current_user = @my_swap_requests.count.positive? || @my_products_swaps.count.positive?
  end

  def check_messages_notifications
    return if current_user.nil?

    @messages_on_my_swaps = Message.joins(:swap).where("swaps.user_id = ?", current_user.id) & Message.where(notify_message_owner: true)
    @messages_on_my_products = Message.joins(swap: [:product]).where("products.user_id = ?", current_user.id) & Message.where(notify_message_receiver: true)
    @swaps_with_new_messages = []
    @messages_on_my_swaps.each do |message|
      @swaps_with_new_messages.push(message.swap_id)
    end
    @messages_on_my_products.each do |message|
      @swaps_with_new_messages.push(message.swap_id)
    end

    @new_message = @messages_on_my_swaps.count.positive? || @messages_on_my_products.count.positive?
  end
end
