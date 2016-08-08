class PersonOrgsController < ApplicationController
  before_action :set_person_org, only: [:show, :edit, :update]

  # GET /person_orgs
  # GET /person_orgs.json
  def index
    @person_orgs = PersonOrg.all
  end

  # GET /person_orgs/1
  # GET /person_orgs/1.json
  def show
  end

  # GET /person_orgs/new
  def new
    @person_org = PersonOrg.new
  end

  # GET /person_orgs/1/edit
  def edit
  end

  # POST /person_orgs
  # POST /person_orgs.json
  def create
    @person_org = PersonOrg.new(person_org_params)

    respond_to do |format|
      if @person_org.save
        format.html { redirect_to @person_org, notice: 'Person org was successfully created.' }
        format.json { render :show, status: :created, location: @person_org }
      else
        format.html { render :new }
        format.json { render json: @person_org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /person_orgs/1
  # PATCH/PUT /person_orgs/1.json
  def update
    respond_to do |format|
      if @person_org.update(person_org_params)
        format.html { redirect_to @person_org, notice: 'Person org was successfully updated.' }
        format.json { render :show, status: :ok, location: @person_org }
      else
        format.html { render :edit }
        format.json { render json: @person_org.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_org
      @person_org = PersonOrg.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def person_org_params
      params.require(:person_org).permit(:name, :active, :is_organization, :contact_phone,
                                         :contact_email, :notes)
    end
end
