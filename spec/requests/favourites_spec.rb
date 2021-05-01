require 'rails_helper'

RSpec.describe 'Favourites', type: :request do
  # Initialize the test data
  let!(:user) { create(:user) }
  let!(:user_id) { user.id }
  let!(:house) { create(:house) }
  let!(:favourite) { create_list(:favourite, 20, user_id: user.id) }
  let(:id) { favourite.first.id }

  # Test suite for GET /user/:user_id/favourite
  describe 'GET /user/:user_id/favourite' do
    before { get "/user/#{user_id}/favourite" }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all user favourite' do
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

  # # Test suite for GET /todos/:user_id/favourite/:id
  # describe 'GET /todos/:user_id/favourite/:id' do
  #   before { get "/todos/#{user_id}/favourite/#{id}" }

  #   context 'when user item exists' do
  #     it 'returns status code 200' do
  #       expect(response).to have_http_status(200)
  #     end

  #     it 'returns the item' do
  #       expect(json['id']).to eq(id)
  #     end
  #   end

  #   context 'when user item does not exist' do
  #     let(:id) { 0 }

  #     it 'returns status code 404' do
  #       expect(response).to have_http_status(404)
  #     end

  #     it 'returns a not found message' do
  #       expect(response.body).to match(/Couldn't find Item/)
  #     end
  #   end
  # end

  # # Test suite for PUT /todos/:user_id/favourite
  # describe 'POST /todos/:user_id/favourite' do
  #   let(:valid_attributes) { { name: 'Visit Narnia', done: false } }

  #   context 'when request attributes are valid' do
  #     before { post "/todos/#{user_id}/favourite", params: valid_attributes }

  #     it 'returns status code 201' do
  #       expect(response).to have_http_status(201)
  #     end
  #   end

  #   context 'when an invalid request' do
  #     before { post "/todos/#{user_id}/favourite", params: {} }

  #     it 'returns status code 422' do
  #       expect(response).to have_http_status(422)
  #     end

  #     it 'returns a failure message' do
  #       expect(response.body).to match(/Validation failed: Name can't be blank/)
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
