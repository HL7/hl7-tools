class ToolAssessmentsController < ApplicationController
  before_action :set_tool_assessment, only: [:show, :edit, :update, :destroy]

  # GET /tool_assessments
  # GET /tool_assessments.json
  def index
    @tool_assessments = ToolAssessment.all
  end

  # GET /tool_assessments/1
  # GET /tool_assessments/1.json
  def show
  end

  # GET /tool_assessments/new
  def new
    @tool_assessment = ToolAssessment.new
  end

  # GET /tool_assessments/1/edit
  def edit
  end

  # POST /tool_assessments
  # POST /tool_assessments.json
  def create
    @tool_assessment = ToolAssessment.new(tool_assessment_params)

    respond_to do |format|
      if @tool_assessment.save
        format.html { redirect_to @tool_assessment, notice: 'Tool assessment was successfully created.' }
        format.json { render :show, status: :created, location: @tool_assessment }
      else
        format.html { render :new }
        format.json { render json: @tool_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_assessments/1
  # PATCH/PUT /tool_assessments/1.json
  def update
    respond_to do |format|
      if @tool_assessment.update(tool_assessment_params)
        format.html { redirect_to @tool_assessment, notice: 'Tool assessment was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_assessment }
      else
        format.html { render :edit }
        format.json { render json: @tool_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tool_assessments/1
  # DELETE /tool_assessments/1.json
  def destroy
    @tool_assessment.destroy
    respond_to do |format|
      format.html { redirect_to tool_assessments_url, notice: 'Tool assessment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool_assessment
      @tool_assessment = ToolAssessment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_assessment_params
      params.fetch(:tool_assessment, {})
    end
end
