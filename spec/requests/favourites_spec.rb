require 'rails_helper'

RSpec.describe 'Favourites API', type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:house) { create(:house) }
  let!(:favourites) { create_list(:favourite, 20, house_id: house.id, user_id: user.id) }
  let(:id) { favourites.first.id }
  let!(:user_id) { user.id }
  let(:house_id) { house.id }
  let(:headers) { valid_headers }


  # Test suite for GET /users/:user_id/favourite
  describe 'GET /users/:user_id/favourites' do
    before { get "/users/#{user_id}/favourites", params: {}, headers: headers }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user favourites' do
        expect(json.size).to eq(20)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for GET /users/:user_id/favourites/:id
  describe 'GET /users/:user_id/favourites/:id' do
    before { get "/users/#{user_id}/favourites/#{id}", params: {}, headers: headers }

    context 'when user favourite exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the favourite' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when user favourite does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Favourite/)
      end
    end
  end

  # Test suite for POST /users/:user_id/favourites
  describe 'POST /users/:user_id/favourites' do
    let(:valid_attributes) { { house_id: "#{house_id}" }.to_json }

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/favourites", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/favourites", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/message\":\"Validation failed: House must exist\"/)
      end
    end
  end

  # Test suite for PUT /users/:user_id/favourites/:id
  describe 'PUT /users/:user_id/favourites/:id' do
    let(:valid_attributes) { { house_id: "#{house_id}" }.to_json }

    before { put "/users/#{user_id}/favourites/#{id}", params: valid_attributes, headers: headers }

    context 'when favourite exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the favourite' do
        updated_favourite = Favourite.find(id)
        expect(updated_favourite.house_id).to match(house_id)
      end
    end

    context 'when the favourite does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/\"message\":\"Couldn't find Favourite/)
      end
    end
  end

  # Test suite for DELETE /users/:id
  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}/favourites/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
