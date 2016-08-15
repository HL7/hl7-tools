class ToolTechnologiesController < ApplicationController
  before_action :set_tool, only: [:new, :create]
  before_action :set_tool_technology, only: [:show, :edit, :update, :destroy]

  # GET /tool_technologies
  # GET /tool_technologies.json
  def index
    @tool_technologies = ToolTechnology.all
  end

  # GET /tool_technologies/1
  # GET /tool_technologies/1.json
  def show
  end

  # GET /tool_technologies/new
  def new
    @tool_technology = ToolTechnology.new
  end

  # GET /tool_technologies/1/edit
  def edit
  end

  # POST /tool_technologies
  # POST /tool_technologies.json
  def create
    @tool_technology = ToolTechnology.new(tool_technology_params)
    @tool_technology.tool = @tool

    respond_to do |format|
      if @tool_technology.save
        format.html { redirect_to @tool, notice: 'Tool technology was successfully created.' }
        format.json { render :show, status: :created, location: @tool_technology }
      else
        format.html { render :new }
        format.json { render json: @tool_technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_technologies/1
  # PATCH/PUT /tool_technologies/1.json
  def update
    respond_to do |format|
      if @tool_technology.update(tool_technology_params)
        format.html { redirect_to @tool_technology.tool, notice: 'Tool technology was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_technology }
      else
        format.html { render :edit }
        format.json { render json: @tool_technology.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_technologies/1
  # DELETE /tool_technologies/1.json
  def destroy
    @tool_technology.destroy
    respond_to do |format|
      format.html { redirect_to tool_technologies_url, notice: 'Tool technology was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def set_tool_technology
    @tool_technology = ToolTechnology.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_technology_params
    params.require(:tool_technology).permit(:technology, :tech_version, :note)
  end
end
