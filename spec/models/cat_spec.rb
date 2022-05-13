require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should have a name" do
      cat = Cat.create age: 3, enjoys: "all the attention"
      expect(cat.errors[:name]).to_not be_empty
  end
  it "should have an age" do
    cat = Cat.create name: 'Toasty', enjoys: "all the attention"
    expect(cat.errors[:age]).to_not be_empty
  end
  it "should have an enjoys" do
    cat = Cat.create name: 'Toasty', age: 2
    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it "should have an image" do
    cat = Cat.create name: 'Toasty', age: 2
    expect(cat.errors[:image]).to_not be_empty
  end
  it "should have an enjoys length" do
    cat = Cat.create name: 'Toasty', age: 2
    expect(cat.errors[:enjoys length]).to_not be_empty
  end
  it "enjoys must have minimum length of ten" do
    cat = Cat.create name:'Moose', age:4,enjoys:'hiking', image:'https://m.media-amazon.com/images/I/812nB8o+guL._AC_SX466_.jpg'

    expect(cat.errors[:enjoys]).to_not be_empty
  end
end
