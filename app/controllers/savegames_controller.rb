class SavegamesController < ApplicationController
  before_filter :authenticate
  before_filter :check_ownership, :only => [:show, :edit, :update]
  
  def new
    @savegame = Savegame.new
    @title = "Create New Save"
  end
  
  def create
    @savegame = current_user.savegames.build(params[:savegame])
    if @savegame.save
      flash[:success] = "New save created: #{@savegame.name}"
      redirect_to(@savegame)
    else
      @title = "Create New Save"
      render 'new'
    end
  end
  
  def show
    @savegame = Savegame.find(params[:id])
    @title = "Save: #{@savegame.name}"
  end
  
  def index
    @savegames = Savegame.find_all_by_user_id(current_user.id)
    @title = "My saves"
  end
  
  def edit
    @title = "Edit Save"
  end
  
  def update
    if @savegame.update_attributes(params[:savegame])
      flash[:success] = "Save updated"
      redirect_to savegames_path
    else
      @title = "Edit Save"
      render 'edit'
    end
  end
  
  private
  
    def authenticate
      deny_access unless signed_in?
    end
    
    def check_ownership
      @savegame = Savegame.find(params[:id])
      steer_back(savegames_path) unless @savegame.user == current_user
    end
  
  #end

end
