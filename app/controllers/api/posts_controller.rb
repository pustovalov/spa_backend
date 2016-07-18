module Api
  class PostsController < ApplicationController
    def index
      @posts = Post.all
      render json: { ok: true, result: @posts }, status: :ok
    end

    def new
      @post = Post.new
      render json: { ok: true, result: @post }, status: :ok
    end

    def create
      @post = Post.new(posts_params)
      if @post.save
        render json: { ok: true, result: @post }, status: :ok
      else
        render json: { ok: false, errors: @post.errors }, status: :unprocessable_entity
      end
    end

    def update
      @post = Post.find(params[:id])
      if @post.update(posts_params)
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

    def posts_params
      params.require(:post).permit(:id, :title, :body, :email)
    end
  end
end
