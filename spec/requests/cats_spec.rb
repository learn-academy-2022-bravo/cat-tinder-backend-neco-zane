require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
     Cat.create( 
       name: 'Giraffe', 
       age: 3, 
       enjoys: 'Eating tuna',
       image: 'https://www.indeed.com/'
      )
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
          age: 3, 
          enjoys: 'Eating tuna',
          image: 'https://www.indeed.com/'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq('Giraffe')
      expect(cat.age).to eq(3)
      expect(cat.enjoys).to eq('Eating tuna')
      expect(cat.image).to eq('https://www.indeed.com/')
    end
  end

  describe "can request validation" do
    it 'doesnt create a cat without a name' do
      cat_params = {
        cat: {
          name: "",
          age: 3, 
          enjoys: 'Eating tuna and chips',
          image: 'https://www.indeed.com/'
      }
    }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end
    it "doesn't create a cat without a age" do
      cat_params = {
        cat: {
          name: 'Giraffe',
          enjoys: 'Eating tuna',
          image: 'https://www.indeed.com/'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['age']).to include "can't be blank"
    end
    it "doesn't create a cat without a enjoys" do
      cat_params = {
        cat: {
          name: 'Eating tuna',
          age: 3,
          image: 'https://www.indeed.com/'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['enjoys']).to include "can't be blank"
    end
    it "doesn't create a cat without a image" do
      cat_params = {
        cat: {
          name: 'Giraffe',
          age: 3,
          enjoys: 'Eating tuna'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)
      json = JSON.parse(response.body)
      expect(json['image']).to include "can't be blank"
    end
  end
end
