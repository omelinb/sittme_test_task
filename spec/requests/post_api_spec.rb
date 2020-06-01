require 'rails_helper'
require 'pry'

RSpec.describe 'Post API', type: :request do
  context 'post creation' do
    it 'creates a post' do
      post '/api/v1/posts', params: { post: { title: 'Title', text: 'Text' } }

      expect(response).to have_http_status(:created)
    end
  end

  context 'posts pagination' do
    let!(:posts) { create_list :post, 50 }
    let(:first) { posts.first }
    let(:last) { posts.last }

    it 'returns empty data' do
      get api_v1_posts_path

      expect(JSON.parse(response.body)['data'].size).to eq(0)
    end

    it 'returns specific count of posts' do
      get api_v1_posts_path('page[before]' => last.id, 'page[size]' => 5)

      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end

    it 'returns correct count of posts in range' do
      get api_v1_posts_path('page[before]' => last.id, 'page[after]' => first.id)

      expect(JSON.parse(response.body)['data'].size).to eq(posts.size - 2)
    end

    it 'returns link to next page' do
      get api_v1_posts_path('page[after]' => first.id)      

      expect(JSON.parse(response.body)['links'].key?('next_page')).to eq(true)
    end

    it 'returns link to prev page' do
      get api_v1_posts_path('page[before]' => last.id)      

      expect(JSON.parse(response.body)['links'].key?('prev_page')).to eq(true)
    end
  end
end
