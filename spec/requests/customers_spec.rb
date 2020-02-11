require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    it "works! (now write some real specs)" do
      get customers_path
      expect(response).to have_http_status(200)
    end

    it "works! 200 ok" do
      get "/customers.json"
      expect(response).to have_http_status(200)
      expect(response.body).to include_json([
        id: /\d/,
        name: (be_kind_of String),
        email: (be_kind_of String),
      ])
    end

    it "create" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = {"ACCEPT" => "application/json"}

      customers_params = attributes_for(:customer)
      post "/customers.json", params: { customer: customers_params }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: customers_params[:name],
        email: customers_params[:email],
      )
    end

    it "update" do
      member = create(:member)
      login_as(member, scope: :member)

      headers = {"ACCEPT" => "application/json"}

      customers  = Customer.first
      customers.name +=" - Updated"

      patch "/customers/#{customers.id}.json", params: { customer: customers.attributes }, headers: headers

      expect(response.body).to include_json(
        id: /\d/,
        name: customers.name,
        email: customers.email,
      )
    end
  end
end

