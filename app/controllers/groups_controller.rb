class GroupsController < ApplicationController

  before_action :unthenticated_user!

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:notice] = "Created Success!"
      redirect_to groups_path
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
      if @group.update(group_params)
        flash[:notice] = "Update Success!"
        redirect_to groups_path
      else
        render :edit
      end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "Group deleted!"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end



end
