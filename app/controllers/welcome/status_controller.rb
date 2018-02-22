class Welcome::StatusController < ApplicationController
  def show
    render json: { ok: true }
  end
end
