require 'rails_helper'

RSpec.describe Document, type: :model do
  def new_document(image_url)
    Document.new(title: "My Book Title",
                 description: "yyy",
                 price: 1,
                 image_url: image_url)
  end
  def create_document(image_url)
    Document.new(title: "My Book Title",
                 description: "yyy",
                 price: 1,
                 image_url: image_url)
  end
  def new_invoice()
    Invoice.new
  end
  def new_line_item(document_id, invoice_id)
    LineItem.new({
                   document_id:document_id,
                   invoice_id:invoice_id
                 })
  end
  def dummy_line_item()
    document = new_document('12.jpg')
    invoice = new_invoice()
    LineItem.new({
                   document_id:document.id,
                   invoice_id:invoice.id
                 })
  end
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

    it 'cannot delete document in invoice' do
      document = create_document('12.jpg')
      invoice = Invoice.create
      line_item = LineItem.create({
                                     document_id:document.id,
                                     invoice_id:invoice.id,
                               })
      expect{Document.find(document.id).destroy!}.to raise_error
    end
  end
end
