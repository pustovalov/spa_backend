module Api
  class PostsController < ApplicationController
    def index
      @posts = Post.all
      render json: { ok: true, result: @posts }, status: :ok
    end

    def show
      @post = Post.find(params[:id])
      if @post
        render json: { ok: true, result: @post }, status: :ok
      else
        render json: { ok: false, result: nil }, status: :not_found
      end
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        render json: { ok: true, result: @post }, status: :ok
      else
        render json: { ok: false, errors: @post.errors }, status: :unprocessable_entity
      end
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(post_params)
        render json: { ok: true, result: @post }, status: :ok
      else
        render json: { ok: false, errors: @post.errors }, status: :not_acceptable
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      render json: { ok: true }, status: :ok
    end

    def post_params
      params.require(:post).permit(:id, :title, :body, :username)
    end
  end
end
