class ToolUsersController < ApplicationController
  before_action :set_tool, only: [:new, :create]
  before_action :set_tool_user, only: [:show, :edit, :update, :destroy]

  # GET /tool_users/new
  def new
    @tool_user = ToolUser.new
  end

  # GET /tool_users/1/edit
  def edit
  end

  # POST /tool_users
  # POST /tool_users.json
  def create
    @tool_user = ToolUser.new(tool_user_params)
    @tool_user.tool = @tool

    respond_to do |format|
      if @tool_user.save
        format.html { redirect_to @tool, notice: 'Tool user was successfully created.' }
        format.json { render :show, status: :created, location: @tool_user }
      else
        format.html { render :new }
        format.json { render json: @tool_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_users/1
  # PATCH/PUT /tool_users/1.json
  def update
    respond_to do |format|
      if @tool_user.update(tool_user_params)
        format.html { redirect_to @tool_user.tool, notice: 'Tool user was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_user }
      else
        format.html { render :edit }
        format.json { render json: @tool_user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def set_tool_user
    @tool_user = ToolUser.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_user_params
    params.require(:tool_user).permit(:work_group_id, :organization_name, :external_list)
  end
end
