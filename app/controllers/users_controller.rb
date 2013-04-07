class UsersController < ApplicationController
#  before_filter :signed_in_user,  only: [:index, :edit, :update, :destroy, :following, :followers]
#  before_filter :correct_user, only: [:edit, :update]
#  before_filter :admin_user, only: :destroy


def show
     @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
end

