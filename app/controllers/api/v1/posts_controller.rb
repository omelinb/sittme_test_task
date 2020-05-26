require 'pry'

class Api::V1::PostsController < ApplicationController
  before_action :page_params, only: [:index]

  # GET /api/v1/posts
  def index
    render json: Post.page(@limit, @cursor)
  end

  def create
  end

  private

  def page_params
    @limit = (params[:limit] || 10).to_i
    @cursor = (params[:cursor] || 0).to_i
  end
end

