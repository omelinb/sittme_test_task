require 'pry'

class Api::V1::PostsController < ApplicationController
  before_action :page_params, only: [:index]
  before_action :post_params, only: [:create]

  # GET /api/v1/posts
  def index
    render json: Post.page(@limit, @cursor)
  end

  # POST /api/v1/posts
  def create
    post = Post.create(post_params)
    if post.save
      render json: post, status: :created
    else
      render json: { errors: post.errors }, status: :unprocessable_entity
    end
  end

  private

  def page_params
    @limit = (params[:limit] || 10).to_i
    @cursor = (params[:cursor] || 0).to_i
  end

  def post_params
    binding.pry
    params.require(:post).permit(:title, :text)
  end
end

