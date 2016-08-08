class ToolNotesController < ApplicationController
  before_action :set_tool, only: [:new, :create]
  before_action :set_tool_note, only: [:show, :edit, :update]

  # GET /tool_notes/new
  def new
    @tool_note = ToolNote.new
  end

  # GET /tool_notes/1/edit
  def edit
  end

  # POST /tool_notes
  # POST /tool_notes.json
  def create
    @tool_note = ToolNote.new(tool_note_params)
    @tool_note.tool = @tool

    respond_to do |format|
      if @tool_note.save
        format.html { redirect_to @tool, notice: 'Tool note was successfully created.' }
        format.json { render :show, status: :created, location: @tool_note }
      else
        format.html { render :new }
        format.json { render json: @tool_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tool_notes/1
  # PATCH/PUT /tool_notes/1.json
  def update
    respond_to do |format|
      if @tool_note.update(tool_note_params)
        format.html { redirect_to @tool_note.tool, notice: 'Tool note was successfully updated.' }
        format.json { render :show, status: :ok, location: @tool_note }
      else
        format.html { render :edit }
        format.json { render json: @tool_note.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_tool
    @tool = Tool.find(params[:tool_id])
  end

  def set_tool_note
    @tool_note = ToolNote.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tool_note_params
    params.require(:tool_note).permit(:note, :note_date, :author)
  end
end
