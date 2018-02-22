class Users::AutocompletionsController < ApplicationController
  def index
    @users = if params[:term]
               User.any_of({ name: /.*#{params[:term]}.*/i }, email: /.*#{params[:term]}.*/i).limit(5)
             else
               User.all
             end

    respond_to do |format|
      format.json { render json: @users.map { |u| { value: u.id.to_s, label: u.name, desc: u.email } }.to_json }
    end
  end
end
