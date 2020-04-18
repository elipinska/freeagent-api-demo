require "rails_helper"

RSpec.describe FreeagentApi::Authentication, :type => :model do
  let(:authentication) { create(:authentication) }

  describe "attributes" do
    it "has all expected attributes" do
      expect(authentication).to have_attributes(
        access_token: "1rYYZLcKnutsIt2ETdP3zxEC0X8Xr9Geby934_O5B",
        refresh_token: "1tL2_xBH6MN0vOma4LhItirikijpVOP5OwB5PmRF9",
        expires_at: Time.zone.parse("2020-04-25 22:30:45")
      )
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:user) }
  end

  describe "#update_access_token" do
    context "given valid new params" do
      it "should update the access token and expires_at fields" do
        new_params = {
          "access_token" => "2YotnFZFEjr1zCsicMWpAA",
          "token_type" => "bearer",
          "expires_in" => 604800,
        }
        authentication.update_access_token(new_params)
        expect(authentication.access_token).to eq(new_params["access_token"])
        rounded_expected_time = (Time.zone.now + new_params["expires_in"]).to_date
        expect(authentication.expires_at.to_date).to eq(rounded_expected_time)
      end
    end

    context "if the expiry time is missing" do
      it "should throw an error" do
        incomplete_params = {
          "access_token" => "2YotnFZFEjr1zCsicMWpAA",
          "token_type" => "bearer",
         }

        expect { authentication.update_access_token(incomplete_params) }.to raise_error(KeyError)
      end
    end

    context "if the access_token is missing" do
      it "should throw an error" do
        incomplete_params = {
          "token_type" => "bearer",
          "expires_in" => 604800,
         }

        expect { authentication.update_access_token(incomplete_params) }.to raise_error(KeyError)
      end
    end

    context "with nil params" do
      it "should throw an error" do
        params = nil

        expect { authentication.update_access_token(params) }.to raise_error(
          RuntimeError,
          "No new params have been given"
        )
      end
    end
  end
end
