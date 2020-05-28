class Api::V1::PostsController < ApplicationController
  include Paginable
  before_action :post_params, only: [:create]

  # GET /api/v1/posts
  def index
    posts = Post.page(page, per_page)
    options = pagination_links('api_v1_posts_path', Post)
    render json: PostSerializer.new(posts, options).serializable_hash
  end

  # POST /api/v1/posts
  def create
    post = Post.create(post_params)
    if post.save
      render json: PostSerializer.new(post).serializable_hash, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

