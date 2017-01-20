require "rails_helper"

describe SettingsController do
  subject { JSON.parse(response.body) }
  let!(:user) { create(:user) }

  describe "GET #index" do
    it "returns 200 status code" do
      authenticated_header(user)
      get :index
      expect(response.status).to eq(200)
    end

    it "returns 401 status code" do
      get :index
      expect(response.status).to eq(401)
    end
  end

  describe "Change locale" do
    it "returns 200 status code" do
      authenticated_header(user)
      post :edit, params: { locale: "ru" } , as: :json
      expect(subject["user"]["locale"]).to eq("ru")
    end
  end

  describe "Change Name" do
    it "returns 200 status code" do
      authenticated_header(user)
      post :edit, params: { name: "1111" } , as: :json
      expect(subject["user"]["name"]).to eq("1111")
    end
  end
end
