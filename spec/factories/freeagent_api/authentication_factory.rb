FactoryBot.define do
  factory :authentication, class: FreeagentApi::Authentication do
    access_token { "1rYYZLcKnutsIt2ETdP3zxEC0X8Xr9Geby934_O5B" }
    refresh_token { "1tL2_xBH6MN0vOma4LhItirikijpVOP5OwB5PmRF9" }
    expires_at { Time.zone.parse("2020-04-25 22:30:45") }
    user { create(:user) }
  end
end
