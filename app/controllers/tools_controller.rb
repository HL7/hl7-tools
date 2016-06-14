class ToolsController < ApplicationController
  before_action :set_tool, only: [:show, :edit, :update, :destroy]

  # GET /tools
  # GET /tools.json
  def index
    @tools = Tool.all
  end

  # GET /tools/1
  # GET /tools/1.json
  def show
  end

  # GET /tools/new
  def new
    # @tool = Tool.new
    redirect_to :index
  end

  # GET /tools/1/edit
  def edit
    redirect_to :index
  end

  # POST /tools
  # POST /tools.json
  def create
    redirect_to :index
    # @tool = Tool.new(tool_params)
    #
    # respond_to do |format|
    #   if @tool.save
    #     format.html { redirect_to @tool, notice: 'Tool was successfully created.' }
    #     format.json { render :show, status: :created, location: @tool }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @tool.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /tools/1
  # PATCH/PUT /tools/1.json
  def update
    redirect_to :index
    # respond_to do |format|
    #   if @tool.update(tool_params)
    #     format.html { redirect_to @tool, notice: 'Tool was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @tool }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @tool.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_params
      params.require(:tool).permit(:name, :description, :purpose, :url, :version, :rollout_date, :last_update_date)
    end
end
