FactoryBot.define do
  factory :request, class: FreeagentApi::Request do
    name { "Create new invoice" }
    endpoint { "/v2/invoices" }
    add_attribute(:method) { "post" }
    body { "{ \"invoice\":\r\n{\r\n\"contact\":\"https://api.freeagent.com/v2/contacts/<CONTACT_ID>\",\r\n\"dated_on\":\"2019-12-12\",\r\n\"payment_terms_in_days\":30\r\n}\r\n}" }
  end
end
