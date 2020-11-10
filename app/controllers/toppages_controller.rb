class ToppagesController < ApplicationController
  def index
    @groups = Group.order(id: :desc).page(params[:page]).per(25)
  end
end
