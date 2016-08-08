class ToolDependenciesController < ApplicationController
  before_action :set_tool_dependency, only: [:show, :edit, :update, :destroy]

  # GET /tool_dependencies
  # GET /tool_dependencies.json
  def index
    @tool_dependencies = ToolDependency.all
  end

  # GET /tool_dependencies/1
  # GET /tool_dependencies/1.json
  def show
  end

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

    respond_to do |format|
      if @tool_dependency.save
        format.html { redirect_to @tool_dependency, notice: 'Tool dependency was successfully created.' }
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
        format.html { redirect_to @tool_dependency, notice: 'Tool dependency was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_dependency }
      else
        format.html { render :edit }
        format.json { render json: @tool_dependency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_dependencies/1
  # DELETE /tool_dependencies/1.json
  def destroy
    @tool_dependency.destroy
    respond_to do |format|
      format.html { redirect_to tool_dependencies_url, notice: 'Tool dependency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_dependency
      @tool_dependency = ToolDependency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_dependency_params
      params.fetch(:tool_dependency, {})
    end
end
