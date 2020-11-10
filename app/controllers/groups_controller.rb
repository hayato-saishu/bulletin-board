class GroupsController < ApplicationController
  def index
    p params
    @name = params[:name]
    puts @name
    if @name == nil
      @groups = Group.order(id: :desc).page(params[:page]).per(25)
    else
      @groups = Group.where(['name LIKE ?', "%#{@name}%"]).order(id: :desc).page(params[:page]).per(25)
    end
  end

  def show
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
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = 'グループを削除しました'
    redirect_to root_url
  end
  
  private
  
  def group_params 
    params.require(:group).permit(:name, :comment)
  end
end
