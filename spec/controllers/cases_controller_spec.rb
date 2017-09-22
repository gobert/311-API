require 'spec_helper'

describe CasesController, type: :controller do
  describe 'GET /cases.json' do
    let!(:open_case)   { Case.create(status: 'Open') }
    let!(:closed_case) { Case.create(status: 'Closed') }
    let!(:sf_case)     { Case.create(lat: '37.8', lng: '-122.4') }
    let!(:categorized_case) { Case.create(service: category) }
    let(:category)          { 'Street and Sidewalk Cleaning' }

    before { get :index, http_params.merge(format: 'json') }

    describe 'having status=Open' do
      let(:result)      { JSON.parse(response.body) }
      let(:result_id)   { JSON.parse(response.body).first['id'] }
      let(:http_params) { Hash[status: 'Open'] }

      it 'filters out not open cases' do
        expect(result.size).to eq(1)
      end

      it 'returns open cases' do
        expect(result_id).to eq(open_case.id)
      end
    end

    describe 'having status=Closed' do
      let(:result)      { JSON.parse(response.body) }
      let(:result_id)   { JSON.parse(response.body).first['id'] }
      let(:http_params) { Hash[status: 'Closed'] }

      it 'filters out not closed cases' do
        expect(result.size).to eq(1)
      end

      it 'returns closed cases' do
        expect(result_id).to eq(closed_case.id)
      end
    end

    describe 'having category' do
      let(:result)      { JSON.parse(response.body) }
      let(:result_id)   { JSON.parse(response.body).first['id'] }
      let(:http_params) { Hash[category: category] }

      it 'filters out cases that not being in this category' do
        expect(result.size).to eq(1)
      end

      it 'returns cases with this category' do
        expect(result_id).to eq(categorized_case.id)
      end
    end

    describe 'having near' do
      let(:result)      { JSON.parse(response.body) }
      let(:result_id)   { JSON.parse(response.body).first['id'] }
      let(:http_params) { Hash[status: 'Closed'] }

      it 'filters out not closed cases' do
        expect(result.size).to eq(1)
      end

      it 'returns closed cases' do
        expect(result_id).to eq(closed_case.id)
      end
    end

    describe 'having near' do
      let(:result)      { JSON.parse(response.body) }
      let(:result_id)   { JSON.parse(response.body).first['id'] }
      let(:http_params) { Hash[near: '37.77,-122.48'] }

      it 'filters out cases not within 5 miles' do
        expect(result.size).to eq(1)
      end

      it 'returns cases within 5 miles' do
        expect(result_id).to eq(sf_case.id)
      end

      context 'with invalid attributes' do
        let(:http_params) { Hash[near: '37,77 -122,48'] }

        it 'returns status 400' do
          expect(response.status).to eq(400)
        end
      end
    end
  end
end
