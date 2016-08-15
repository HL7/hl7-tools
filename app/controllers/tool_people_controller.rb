class ToolPeopleController < ApplicationController
  before_action :set_tool, only: [:new, :create]
  before_action :set_tool_person, only: [:show, :edit, :update, :destroy]

  # GET /tool_people/new
  def new
    @tool_person = ToolPerson.new
  end

  # GET /tool_people/1/edit
  def edit
  end

  # POST /tool_people
  # POST /tool_people.json
  def create
    @tool_person = ToolPerson.new(tool_person_params)
    @tool_person.tool = @tool

    respond_to do |format|
      if @tool_person.save
        format.html { redirect_to @tool, notice: 'Tool person was successfully created.' }
        format.json { render :show, status: :created, location: @tool_person }
      else
        format.html { render :new }
        format.json { render json: @tool_person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_people/1
  # PATCH/PUT /tool_people/1.json
  def update
    respond_to do |format|
      if @tool_person.update(tool_person_params)
        format.html { redirect_to @tool_person.tool, notice: 'Tool person was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_person }
      else
        format.html { render :edit }
        format.json { render json: @tool_person.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def set_tool_person
    @tool_person = ToolPerson.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_person_params
    params.require(:tool_person).permit(:activity, :notes, :person_org_id, :updated_at,
                                        { role: [] })
  end
end
