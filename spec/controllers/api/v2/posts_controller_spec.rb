require "rails_helper"

describe Api::V2::PostsController do
  subject { JSON.parse(response.body).fetch("result") }

  describe "GET #index" do
    let!(:posts) { create_list(:post, 3) }
    before { request }

    it "returns 200 status code" do
      expect(response.status).to eq(200)
    end

    it "returns list of posts" do
      expect(subject.length).to eq(posts.length)
    end

    def request
      get :index, params: { page: 1, per: 3, order: "ASC" }, as: :json
    end
  end

  describe "GET #index with paramaters" do
    let!(:posts) { create_list(:post, 10) }

    it "returns 200 status code" do
      expect(response.status).to eq(200)
    end

    context "ASC order" do
      before {
        get :index, params: { page: 1, per: 3, order: "ASC" }, as: :json
      }

      it "has right order" do
        expect(subject.first["id"]).to eq(posts.first.id)
      end
    end

    context "DESC order" do
      before {
        get :index, params: { page: 1, per: 3, order: "DESC" }, as: :json
      }

      it "has rigth order" do
        expect(subject.first["id"]).to eq(posts.last.id)
      end
    end

    context "Page filter" do

      context "1 post" do
        before {
          get :index, params: { page: 1, per: 1, order: "ASC" }, as: :json
        }

        it "per page" do
          expect(subject.length).to eq(1)
        end
      end

      context "5 posts" do
        before {
          get :index, params: { page: 1, per: 5, order: "ASC" }, as: :json
        }

        it "per page" do
          expect(subject.length).to eq(5)
        end
      end
    end

    context "Per filter" do

      context "first page" do
        before {
          get :index, params: { page: 1, per: 5, order: "ASC" }, as: :json
        }

        it "has first post" do
          expect(subject.first["id"]).to eq(posts.first.id)
        end

        it "has last post with id 5" do
          expect(subject.last["id"]).to eq(posts[4].id)
        end
      end

      context "second page" do
        before {
          get :index, params: { page: 2, per: 5, order: "ASC" }, as: :json
        }

        it "has first post" do
          expect(subject.first["id"]).to eq(posts[5].id)
        end

        it "has last post with id 10" do
          expect(subject.last["id"]).to eq(posts[9].id)
        end
      end
    end

    context "Search" do
      let!(:post) { create(:post, title: "search") }

      before {
        get :index, params: { page: 1, per: 5, order: "ASC", search: "search" }, as: :json
      }

      it "has only one post" do
        expect(subject.length).to eq(1)
      end

      it "has right post" do
        expect(subject.first["title"]).to eq(post.title)
      end
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
