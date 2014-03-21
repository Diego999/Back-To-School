class EstablishmentsController < ApplicationController
  def show
    @establishment = Establishment.find(params[:id])
    @current_user = current_user
  end
end
