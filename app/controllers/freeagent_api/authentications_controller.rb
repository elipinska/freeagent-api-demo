# frozen_string_literal: true
module FreeagentApi
  class AuthenticationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_freeagent_api_authentication, only: [:show, :edit, :update, :destroy]
    before_action :set_api_client, only: [:new, :create, :update]

    # GET /freeagent_api/authentications/1
    # GET /freeagent_api/authentications/1.json
    def show
    end

    # GET /freeagent_api/authentications/new
    def new
      existing_authentication = current_user.freeagent_api_authentication
      if existing_authentication
        redirect_to existing_authentication, notice: "Looks like you already have access to the API!"
      end

      @url = @api_client.authorize_url
    end

    # POST /freeagent_api/authentications
    # POST /freeagent_api/authentications.json
    def create
      response = get_tokens(authorisation_code: params["code"])

      unless response.success?
        redirect_to new_freeagent_api_authentication_path, notice: "Something went wrong... Better luck next time!"
        return
      end

      response_body = JSON.parse(response.body)
      @freeagent_api_authentication = FreeagentApi::Authentication.new(
        access_token: response_body["access_token"],
        refresh_token: response_body["refresh_token"],
        expires_at: Time.zone.now + response_body["expires_in"],
        user: current_user
      )

      respond_to do |format|
        if @freeagent_api_authentication.save
          format.html { redirect_to @freeagent_api_authentication, notice: "You've successfully authenticated with FreeAgent!"}
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
      new_params = @api_client.refresh_access_token(refresh_token: @freeagent_api_authentication.refresh_token)

      if @freeagent_api_authentication.update_access_token(new_params)
        redirect_to @freeagent_api_authentication, notice: "Access token was successfully updated."
      else
        render :edit
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
end
