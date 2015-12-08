class ProfileController < ApplicationController
   def index

   @profiles = Profile.all
   end

 def new
   @profile = Profile.new
 end

 def create
   @profile = Profile.new(profile_params)
  #  @profile.user_id = current_user.id
   if @profile.save
     redirect_to '/profile'
   else
     render 'new'
   end
 end


 def profile_params
   params.require(:profile).permit(:status, :name, :surname, :language, :expertise, :occupation, :location)
 end

 def show
   @profile = Profile.find(params[:id])
 end

 def edit
   @profile = Profile.find(params[:id])

 end

 def update
   @profile = Profile.find(params[:id])


   if @profile.user_id == current_user.id
     @profile.update(profile_params)
     flash[:notice] = 'Profile updated successfully'
   else
     flash[:notice] = 'You have no permission to update this profile'
   end

   redirect_to '/profile'
 end

 def destroy
   @profile = Profile.find(params[:id])
   if @profile.user_id == current_user.id
     @profile.destroy
     flash[:notice] = 'Profile deleted successfully'
   else
     flash[:notice] = 'You have no permission to delete this profile'
   end


   redirect_to '/profile'
 end

end