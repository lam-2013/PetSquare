class PetsController < ApplicationController
  before_filter :signed_in_user

  def index (user)
    @pets=user.pets
  end

  def show
    @pet=Pet.find(params[:id])
    @checkins = @pet.checkins
  end

  def new
    @pet=Pet.new
  end

  def create
    @pet=current_user.pets.build(params[:pet])
    if @pet.save
      # handle a successful save
      flash[:success] = 'Pet profilo created'
      redirect_to @pet
    else
      @feed_items = []
      render 'new'
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update_attributes(params[:pet])
      # handle a successful update
      flash[:success] = 'Profile updated'
      # go to the user profile
      redirect_to @pet
    else
      render 'edit'
    end
  end

  def destroy
    @pet.destroy
    redirect_to root_url
  end

  def followers
    @title = "Followers"
    @pet = Pet.find(params[:id])
    @users = @pet.follower_users
    render 'show_follow'
  end

  def search
    if params[:search].empty?
      flash.now[:error] = "Il campo razza deve essere pieno"
      render 'pets/search_form'
    else
    @pets = Pet.search(params[:search])
    end
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def pet_params
    params.require(:pet).permit(:namePet, :breed, :description)
  end

  # Redirect the user to the home page is she is not an admin (e.g., if the user cannot perform an admin-only operation)
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end
