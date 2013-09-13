class RelationshipsController < ApplicationController
  respond_to :html, :js

  def create
    @user =User.find_by_email(current_user.email)
    @pet = Pet.find(params[:relationship][:followed_id])
    current_user.follow!(@pet)

    respond_with @pet
  end

  def destroy
    @pet = Relationship.find(params[:id]).followed
    current_user.unfollow!(@pet)
    respond_with @pet
  end
end
