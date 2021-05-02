require 'rails_helper'

RSpec.describe 'Favourites API', type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:house) { create(:house) }
  let!(:favourites) { create_list(:favourite, 20, house_id: house.id, user_id: user.id) }
  let(:id) { favourites.first.id }
  let!(:user_id) { user.id }
  let(:house_id) { house.id }

  # Test suite for GET /users/:user_id/favourite
  describe 'GET /users/:user_id/favourites' do
    before { get "/users/#{user_id}/favourites" }

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

  # # Test suite for GET /users/:user_id/favourites/:id
  # describe 'GET /users/:user_id/favourites/:id' do
  #   before { get "/users/#{user_id}/favourites/#{id}" }

  #   context 'when user favourite exists' do
  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'returns the favourite' do
  #       expect(json['id']).to eq(id)
  #     end
  #   end

  #   context 'when user favourite does not exist' do
  #     let(:id) { 0 }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Favourites/)
  #     end
  #   end
  # end

  # # Test suite for POST /users/:user_id/favourites
  # describe 'POST /users/:user_id/favourites' do
  #   let(:valid_attributes) { { name: "#{id_house}" } }

  #   context 'when request attributes are valid' do
  #     before { post "/users/#{user_id}/favourites", params: valid_attributes }

  #     it 'returns status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end

  #   context 'when an invalid request' do
  #     before { post "/users/#{user_id}/favourites", params: {} }

  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end

  #     it 'returns a failure message' do
  #       expect(response.body).to match(/message\":\"Validation failed: House must exist\"/)
  #     end
  #   end
  # end

  # # Test suite for PUT /todos/:user_id/favourite/:id
  # describe 'PUT /todos/:user_id/favourite/:id' do
  #   let(:valid_attributes) { { name: 'Mozart' } }

  #   before { put "/todos/#{user_id}/favourite/#{id}", params: valid_attributes }

  #   context 'when item exists' do
  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end

  #     it 'updates the item' do
  #       updated_item = Item.find(id)
  #       expect(updated_item.name).to match(/Mozart/)
  #     end
  #   end

  #   context 'when the item does not exist' do
  #     let(:id) { 0 }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Item/)
  #     end
  #   end
  # end

  # # Test suite for DELETE /todos/:id
  # describe 'DELETE /todos/:id' do
  #   before { delete "/todos/#{user_id}/favourite/#{id}" }

  #   it 'returns status code 204' do
  #     expect(response).to have_http_status(204)
  #   end
  # end
end
