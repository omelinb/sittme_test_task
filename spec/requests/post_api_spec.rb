require 'rails_helper'

RSpec.describe 'Post API', type: :request do
  context 'post creation' do
    it 'creates a post' do
      post '/api/v1/posts', params: { post: { title: 'Title', text: 'Text' } }

      expect(response).to have_http_status(:created)
    end
  end

  context 'posts pagination' do
    let!(:posts) { create_list :post, 50 }

    before { get '/api/v1/posts' }

    it 'returns specific count of posts' do
      expect(JSON.parse(response.body)['data'].size).to eq(10)
    end

    it "doesn't return link to previous page" do
      expect(JSON.parse(response.body)['links'].key?('prev_page')).to eq(false)
    end

    it 'returns link to next page' do
      expect(JSON.parse(response.body)['links'].key?('next_page')).to eq(true)
    end
  end
end
