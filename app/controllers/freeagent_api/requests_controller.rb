class FreeagentApi::RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_freeagent_api_request, only: [:show, :edit, :update, :destroy]

  # GET /freeagent_api/requests
  # GET /freeagent_api/requests.json
  def index
    @freeagent_api_requests = FreeagentApi::Request.all
  end

  # GET /freeagent_api/requests/1
  # GET /freeagent_api/requests/1.json
  def show
  end

  # GET /freeagent_api/requests/new
  def new
    @freeagent_api_request = FreeagentApi::Request.new
  end

  # GET /freeagent_api/requests/1/edit
  def edit
  end

  # POST /freeagent_api/requests
  # POST /freeagent_api/requests.json
  def create
    @freeagent_api_request = FreeagentApi::Request.new(freeagent_api_request_params)

    respond_to do |format|
      if @freeagent_api_request.save
        format.html { redirect_to @freeagent_api_request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @freeagent_api_request }
      else
        format.html { render :new }
        format.json { render json: @freeagent_api_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freeagent_api/requests/1
  # PATCH/PUT /freeagent_api/requests/1.json
  def update
    respond_to do |format|
      if @freeagent_api_request.update(freeagent_api_request_params)
        format.html { redirect_to @freeagent_api_request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @freeagent_api_request }
      else
        format.html { render :edit }
        format.json { render json: @freeagent_api_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freeagent_api/requests/1
  # DELETE /freeagent_api/requests/1.json
  def destroy
    @freeagent_api_request.destroy
    respond_to do |format|
      format.html { redirect_to freeagent_api_requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_freeagent_api_request
      @freeagent_api_request = FreeagentApi::Request.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def freeagent_api_request_params
      params.require(:freeagent_api_request).permit(:endpoint, :method)
    end
end
