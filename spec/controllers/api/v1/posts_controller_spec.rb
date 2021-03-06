require "rails_helper"

describe Api::V1::PostsController do
  subject { JSON.parse(response.body).fetch("result") }

  describe "GET #index" do
    let!(:posts) { create_list(:post, 3) }
    before { get :index }

    it "returns 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns list of posts" do
      expect(subject.length).to eq(posts.length)
    end
  end

  describe "POST #create" do
    let(:post_params) do
       { post: attributes_for(:post) }
     end

    it "returns 200 status code" do
      request(post_params)
      expect(response.status).to eq(200)
    end

    it "changes post count" do
      expect { request(post_params) }.to change(Post, :count).by(1)
    end

    it "returns post" do
      request(post_params)
      expect(subject["title"]).to eq(post_params[:post][:title])
    end

    def request(options = {})
      post :create, as: :json, params: options
    end
  end

  describe "GET #show" do
    let!(:post) { create(:post) }

    before { request }

    it "returns 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns post" do
      expect(subject["id"].to_i).to eq(post.id)
      expect(subject["title"]).to eq(post.title)
    end

    def request
      get :show, params: { id: post.id }, as: :json
    end
  end

  describe "PUT #update" do
    let!(:post) { create(:post, title: "Old title") }
    let(:title) { "New title" }
    let(:post_params) do
      { post: { title: title } }
    end

    before { request }

    it "returns 200 status code" do
      expect(response.status).to eq(200)
    end

    it "update post" do
      expect(subject["title"]).to eq(title)
    end

    def request
      put :update, params: { id: post.id, post: { title: title } } , as: :json
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { create(:post) }

    it "returns 200 status code" do
      request
      expect(response.status).to eq(200)
    end

    it "destroy post" do
      expect { request }.to change(Post, :count).by(-1)
    end

    def request
      delete :destroy, params: { id: post.id }, as: :json
    end
  end
end
