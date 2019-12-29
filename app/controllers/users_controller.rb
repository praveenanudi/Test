class UsersController < ApplicationController

  def index
  	@users = User.all.paginate(:page => params[:page], :per_page => 5)
  	respond_to do |format|
    format.html
    format.json { render json: @users }
  end 
  end


  def import
  	if params[:file].content_type == "application/json"
  	    file = params[:file].read
        data = JSON.parse(file)
        User.create(data)
  	else
  	    User.import(params[:file])
    end
  	redirect_to root_url, notice: "data uploaded succesufully"
  end

   private
  ## Strong Parameters 
  def user_params
    params.require(:user).permit(:id,:login, :password, :title, :lastname,:firstname,:gender,:email,:picture,:address)
  end
end
