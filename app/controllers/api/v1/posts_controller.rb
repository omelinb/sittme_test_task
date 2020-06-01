class Api::V1::PostsController < ApplicationController
  include Paginable::Controller

  before_action :post_params, only: [:create]

  # GET /api/v1/posts
  def index
    posts = Post.get_page(page_before, page_after, page_size)
    options = pagination_links('api_v1_posts_path', posts)
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
