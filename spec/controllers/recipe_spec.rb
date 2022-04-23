require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
  describe 'GET recipes' do
    it 'renders the recipes index template' do
      get '/recipes'
      expect(response).to render_template('index')
    end

    it 'returns a 200 OK status' do
      get '/recipes'
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET recipes_new' do
    it 'renders the show template' do
      get '/recipes/new'
      expect(response).to render_template('new')
    end

    it 'returns the correct text' do
      get '/recipes/new'
      expect(response.body).to include('Use the form below to create new recipe information. Please complete all the fields.')
    end
  end
end
