class GroupsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :new, :create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def index
    p params
    @name = params[:name]
    puts @name
    if @name == nil
      @groups = Group.order(id: :desc).page(params[:page]).per(10)
    else
      @groups = Group.where(['name LIKE ?', "%#{@name}%"]).order(id: :desc).page(params[:page]).per(10)
    end
  end

  def show
    if logged_in?
      @group = Group.find(params[:id])
      @post = @group.posts.build
      @posts = @group.posts.order(id: :desc).page(params[:page]).per(10)
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user_id = current_user.id
    if @group.save
      flash[:success] = 'グループを作成しました'
      redirect_to root_url
    else
      flash[:danger] = 'グループを作成できませんでした'
      render :new
    end
  end

  def destroy
    #@group = Group.find(params[:id])
    @group.destroy
    flash[:success] = 'グループを削除しました'
    redirect_to root_url
  end
  
  private
  
  def group_params 
    params.require(:group).permit(:name, :comment)
  end
  
  def correct_user
    @group = current_user.groups.find_by(id: params[:id])
    unless @group
      redirect_to root_url
    end
  end
end
