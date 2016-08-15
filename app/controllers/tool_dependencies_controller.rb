class ToolDependenciesController < ApplicationController
  before_action :set_tool, only: [:new, :create]
  before_action :set_tool_dependency, only: [:show, :edit, :update, :destroy]

  # GET /tool_dependencies/new
  def new
    @tool_dependency = ToolDependency.new
  end

  # GET /tool_dependencies/1/edit
  def edit
  end

  # POST /tool_dependencies
  # POST /tool_dependencies.json
  def create
    @tool_dependency = ToolDependency.new(tool_dependency_params)
    @tool_dependency.tool = @tool

    respond_to do |format|
      if @tool_dependency.save
        format.html { redirect_to @tool, notice: 'Tool dependency was successfully created.' }
        format.json { render :show, status: :created, location: @tool_dependency }
      else
        format.html { render :new }
        format.json { render json: @tool_dependency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_dependencies/1
  # PATCH/PUT /tool_dependencies/1.json
  def update
    respond_to do |format|
      if @tool_dependency.update(tool_dependency_params)
        format.html { redirect_to @tool_dependency.tool, notice: 'Tool dependency was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_dependency }
      else
        format.html { render :edit }
        format.json { render json: @tool_dependency.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def set_tool_dependency
    @tool_dependency = ToolDependency.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_dependency_params
    params.require(:tool_dependency).permit(:dependency_id, :note)
  end
end
