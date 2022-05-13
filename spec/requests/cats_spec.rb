require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
    Cat.create name: 'Methusal', age: 3, enjoys: 'Eating Pickles'
    get '/cats'
    cat = JSON.parse(response.body)
    expect(response).to have_http_status(200)
    expect(cat.length).to eq 1
   end
  end
  describe "POST /create" do
    it "creates a cat" do

      cat_params = { 
        cat: {
          name: 'Giraffe',
          age: 5, 
          enjoys: 'Looking at trees'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)

      cat = Cat.first
      expect(cat.name).to eq 'Giraffe'
      expect(cat.age).to eq 5
      expect(cat.enjoys).to eq 'Looking at trees'
    end
  end
end
