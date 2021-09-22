require 'rails_helper'

RSpec.describe Document, type: :model do
  context 'DocumentTest' do
    it "document fields must not be empty" do
      document = Document.new
      expect(document.invalid?).to equal true
      expect(document.errors[:title].any?).to equal true
      expect(document.errors[:price].any?).to equal true
      # expect document.errors[:image_url].any?
    end
    it "product price must be positive" do
      document = Document.new(title: "My Book Title",
                              description: "yyy",
                              image_url: "zzz.jpg")
      document.price = -1
      expect(document.invalid?).to equal true
      expect(document.errors[:price]).to contain_exactly("must be greater than or equal to 0.01")

      document.price = 0
      expect(document.invalid?).to equal true
      expect(document.errors[:price]).to contain_exactly("must be greater than or equal to 0.01")

      document.price = 1
      expect(document.valid?).to equal true
    end
    def new_document(image_url)
      Document.new(title: "My Book Title",
                   description: "yyy",
                   price: 1,
                   image_url: image_url)
    end
    it "image url" do
      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
      bad = %w{ fred.doc fred.gif/more fred.gif.more }
      ok.each do |image_url|
        expect(new_document(image_url).valid?).to eq(true), "#{image_url} shouldn't be invalid"
      end
      bad.each do |image_url|
        expect(new_document(image_url).invalid?).to eq(true), "#{image_url} shouldn't be valid"
      end
    end
  end
end
