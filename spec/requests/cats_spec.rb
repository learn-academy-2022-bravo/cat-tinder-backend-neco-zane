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
          image: 'https://townsquare.media/site/396/files/2021/06/attachment-Cat-Walking-On-Beach.jpg'
        }
      }
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq('Giraffe')
      expect(cat.age).to eq(3)
      expect(cat.enjoys).to eq('Eating tuna')
      expect(cat.image).to eq('https://townsquare.media/site/396/files/2021/06/attachment-Cat-Walking-On-Beach.jpg')
    end
  end

  describe "can request validation" do
    it 'doesnt create a cat without a name' do
      cat_params = {
        cat: {
          name: "",
          age: 3, 
          enjoys: 'Eating tuna and chips',
          image: 'https://townsquare.media/site/396/files/2021/06/attachment-Cat-Walking-On-Beach.jpg'
        }
      }
      post '/cats', params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)
      expect(cat['name']).to include "can't be blank"
    end
  end
end
