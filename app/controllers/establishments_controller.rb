class EstablishmentsController < ApplicationController
  before_filter :authenticate_user!
  ensure_authorization_performed

  def show
    @establishment = Establishment.find(params[:id])

    authorize_action_for(@establishment)

    @current_user = current_user
  end
end
