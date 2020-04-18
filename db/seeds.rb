# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

FreeagentApi::Request.create([
  {
    endpoint: "/v2/company",
    method: "get"
  },
  {
    endpoint: "v2/users/me",
    method: "get"
  },
  {
    endpoint: "v2/invoices",
    method: "get"
  }])
