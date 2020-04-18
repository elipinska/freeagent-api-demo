# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FreeagentApi::Request.create([
  {
    name: "General company information",
    endpoint: "/v2/company",
    method: "get"
  },
  {
    name: "Get personal profile",
    endpoint: "v2/users/me",
    method: "get"
  },
  {
    name: "List all invoices",
    endpoint: "v2/invoices",
    method: "get"
  },
  {
    name: "Create new invoice",
    endpoint: "v2/invoices",
    method: "post",
    body: "{ \"invoice\":\r\n{\r\n\"contact\":\"https://api.freeagent.com/v2/contacts/<CONTACT_ID>\",\r\n\"dated_on\":\"2019-12-12\",\r\n\"payment_terms_in_days\":30\r\n}\r\n}"
  }])
