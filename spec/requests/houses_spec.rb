require 'rails_helper'

RSpec.describe 'Houses', type: :request do
  # initialize test data
  let(:user) { create(:user) }

  let!(:houses) { create_list(:house, 10) }
  let!(:house) { create(:house) }

  let(:house_id) { houses.first.id }

  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /houses
  describe 'GET /houses' do
    before { get '/houses/', params: {}, headers: headers }

    it 'returns houses' do
      expect(json).to be_truthy
      expect(json).not_to be_empty
      expect(json.size).to eq(11)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /houses/:id
  describe 'GET /houses/:id' do
    before { get "/houses/#{house_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the house' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(house_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:house_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/"message":"Couldn't find House with 'id'=#{house_id}/)
      end
    end
  end

  # Test suite for POST /houses
  describe 'POST /houses' do
    # valid payload
    let(:valid_attributes) do
      { price: '200', details: 'Luxiry', about: 'Kin house', picture: 'www,gbsismwa.me', owner: '1' }.to_json
    end

    context 'when the request is valid' do
      before { post '/houses', params: valid_attributes, headers: headers }

      it 'creates a house' do
        expect(json['about']).to eq('Kin house')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid (only About is present)' do
      before { post '/houses', params: { about: 'Goma house' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, Price can't be blank, Owner can't be blank/)
      end
    end

    context 'when the request is invalid' do
      before { post '/houses', params: {}.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Picture can't be blank, About can't be blank, Price can't be blank, Owner can't be blank/)
      end
    end

    context 'when the request is invalid (only Picture is present)' do
      before { post '/houses', params: { picture: 'url house' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: About can't be blank, Price can't be blank, Owner can't be blank/)
      end
    end

    context 'when the request is invalid (only Picture is present)' do
      before { post '/houses', params: { picture: 'url house' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: About can't be blank, Price can't be blank, Owner can't be blank/)
      end
    end

    context 'when the request is invalid (only Price is present)' do
      before { post '/houses', params: { price: 'url house' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, About can't be blank, Owner can't be blank/)
      end
    end

    context 'when the request is invalid (only Owner is present)' do
      before { post '/houses', params: { owner: 'url house' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: Picture can't be blank, About can't be blank, Price can't be blank/)
      end
    end

    context 'when the request is invalid (only Owner is present)' do
      before { post '/houses', params: { picture: 'url house', price: '299' }.to_json, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"message":"Validation failed: About can't be blank, Owner can't be blank/)
      end
    end
  end

  # Test suite for PUT /houses/:id
  describe 'PUT /houses/:id' do
    let(:valid_attributes) { { about: 'Shopping House' }.to_json }

    context 'when the record exists' do
      before { put "/houses/#{house_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /houses/:id
  describe 'DELETE /houses/:id' do
    before { delete "/houses/#{house_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
