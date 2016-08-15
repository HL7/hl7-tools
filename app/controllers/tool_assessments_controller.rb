class ToolAssessmentsController < ApplicationController
  before_action :set_tool, only: [:new, :create]

  # GET /tool_assessments/new
  def new
    @tool_assessment = ToolAssessment.new(assessment_date: Date.today, risk: 50, quality: 50,
                                          sustainability: 50, usability: 50)
  end

  # POST /tool_assessments
  # POST /tool_assessments.json
  def create
    @tool_assessment = ToolAssessment.new(tool_assessment_params)
    @tool_assessment.tool = @tool

    respond_to do |format|
      if @tool_assessment.save
        format.html { redirect_to @tool, notice: 'Tool assessment was successfully created.' }
        format.json { render :show, status: :created, location: @tool_assessment }
      else
        format.html { render :new }
        format.json { render json: @tool_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tool
      @tool = Tool.find(params[:tool_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tool_assessment_params
      params.require(:tool_assessment).permit(:note, :assessment_date, :risk, :quality,
                                              :sustainability, :usability)
    end
end
