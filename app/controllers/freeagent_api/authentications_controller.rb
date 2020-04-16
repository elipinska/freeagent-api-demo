class FreeagentApi::AuthenticationsController < ApplicationController
  before_action :set_freeagent_api_authentication, only: [:show, :edit, :update, :destroy]
  before_action :set_api_client, only: [:new, :create]

  # GET /freeagent_api/authentications
  # GET /freeagent_api/authentications.json
  def index
    @freeagent_api_authentications = FreeagentApi::Authentication.all
  end

  # GET /freeagent_api/authentications/1
  # GET /freeagent_api/authentications/1.json
  def show
    @company = HTTParty.get("https://api.sandbox.freeagent.com/v2/company", headers: {
      "Authorization": "Bearer #{@freeagent_api_authentication.access_token}"
      }).body
  end

  # GET /freeagent_api/authentications/new
  def new
    @freeagent_api_authentication = FreeagentApi::Authentication.new
    @url = @api_client.authorize_url
  end

  # GET /freeagent_api/authentications/1/edit
  def edit
  end

  # POST /freeagent_api/authentications
  # POST /freeagent_api/authentications.json
  def create
    response = get_tokens(authorisation_code: params["code"])

    unless response.success? 
      flash[:alert] = "Something went wrong... Better luck next time!"
      redirect_to new_freeagent_api_authentication_path
      return
    end

    @freeagent_api_authentication = FreeagentApi::Authentication.new(
      access_token: response["access_token"], 
      refresh_token: response["refresh_token"], 
      expires_at: Time.zone.now + response["expires_in"]
    )

    flash[:alert] = "You've successfully authenticated with FreeAgent!"

    respond_to do |format|
      if @freeagent_api_authentication.save
        format.html { redirect_to @freeagent_api_authentication }
        format.json { render :show, status: :created, location: @freeagent_api_authentication }
      else
        format.html { redirect_to new_freeagent_api_authentication_path }
        format.json { render json: @freeagent_api_authentication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /freeagent_api/authentications/1
  # PATCH/PUT /freeagent_api/authentications/1.json
  def update
    respond_to do |format|
      if @freeagent_api_authentication.update(freeagent_api_authentication_params)
        format.html { redirect_to @freeagent_api_authentication, notice: 'Authentication was successfully updated.' }
        format.json { render :show, status: :ok, location: @freeagent_api_authentication }
      else
        format.html { render :edit }
        format.json { render json: @freeagent_api_authentication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /freeagent_api/authentications/1
  # DELETE /freeagent_api/authentications/1.json
  def destroy
    @freeagent_api_authentication.destroy
    respond_to do |format|
      format.html { redirect_to freeagent_api_authentications_url, notice: 'Authentication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def get_tokens(authorisation_code:)
    @api_client.request_access_token(authorisation_code: authorisation_code)
  end

  def set_api_client
    @api_client ||= FreeagentApi::Client.new
  end
    
  # Use callbacks to share common setup or constraints between actions.
  def set_freeagent_api_authentication
    @freeagent_api_authentication = FreeagentApi::Authentication.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def freeagent_api_authentication_params
    params.fetch(:freeagent_api_authentication, {})
  end
end
