class GroupsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_group_and_check_permission, only: [:edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    if @group.save


      flash[:notice] = "Created Success!"
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts
  end

  def edit

  end

  def update

      if @group.update(group_params)
        flash[:notice] = "Update Success!"
        redirect_to groups_path
      else
        render :edit
      end
  end

  def destroy


    @group.destroy
    flash[:alert] = "Group deleted!"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

  def find_group_and_check_permission
    @group = Group.find(params[:id])

    if current_user != @group.user
      redirect_to root_path, alert: "You have no permisson."
    end
  end



end
