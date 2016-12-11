module Api
  module V1
    class PostsController < ApplicationController
      include Posts

      def index
        @posts = Post.all
        render json: { ok: true, result: @posts }, status: :ok
      end

      def create
        @post = Post.new(post_params)
        check_save
      end

      def post_params
        params.require(:post).permit(:id, :title, :body, :username)
      end
    end
  end
end
