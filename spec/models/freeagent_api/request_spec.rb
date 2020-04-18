require "rails_helper"

RSpec.describe FreeagentApi::Request, :type => :model do
  let(:request) { create(:request) }

  describe "attributes" do
    it "has all expected attributes" do
      expect(request).to have_attributes(
        name: "Create new invoice",
        endpoint: "/v2/invoices",
        method: "post",
        body: "{ \"invoice\":\r\n{\r\n\"contact\":\"https://api.freeagent.com/v2/contacts/<CONTACT_ID>\",\r\n\"dated_on\":\"2019-12-12\",\r\n\"payment_terms_in_days\":30\r\n}\r\n}"
      )
    end
  end
end
