module Api
  module V2
    class PostsController < ApplicationController
      include Posts

      def index
        @posts = Post
                  .page(params[:page])
                  .per(params[:per])
                  .order(created_at: params[:order])

        @filtered_posts =
          if params[:search].present?
            @posts.search(params[:search])
          else
            @posts
          end

        render json: {
          ok: true,
          result: @filtered_posts,
          meta: {
            current_page: @filtered_posts.current_page,
            next_page: @filtered_posts.next_page,
            prev_page: @filtered_posts.prev_page,
            total_pages: @filtered_posts.total_pages,
            total_count: @filtered_posts.total_count
          }
        },
        status: :ok
      end

      def create
        @post = Post.new(post_params)

        if params[:image].present?
          @post.image = params[:image]
          @post.save!
        end

        check_save
      end

      def post_params
        params.require(:post).permit(:id, :title, :body, :username, :page, :per, :order, :image)
      end
    end
  end
end
