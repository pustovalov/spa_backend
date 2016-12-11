module Posts
  extend ActiveSupport::Concern

  def show
    @post = Post.find(params[:id])
    if @post
      render json: { ok: true, result: @post }, status: :ok
    else
      render json: { ok: false, result: nil }, status: :not_found
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

  def check_save
    if @post.save
      render json: { ok: true, result: @post }, status: :ok
    else
      render json: { ok: false, errors: @post.errors }, status: :unprocessable_entity
    end
  end
end
