require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  test "document fields must not be empty" do
    document = Document.new
    assert document.invalid?
    assert document.errors[:title].any?
    assert document.errors[:price].any?
    # assert document.errors[:image_url].any?
  end
  test "product price must be positive" do
    document = Document.new(title: "My Book Title",
                          description: "yyy",
                          image_url: "zzz.jpg")
    document.price = -1
    assert document.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 document.errors[:price]
    document.price = 0
    assert document.invalid?
    assert_equal ["must be greater than or equal to 0.01"],
                 document.errors[:price]
    document.price = 1
    assert document.valid?
  end
  def new_document(image_url)
    Document.new(title: "My Book Title",
                description: "yyy",
                price: 1,
                image_url: image_url)
  end
  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    ok.each do |image_url|
      assert new_document(image_url).valid?,
             "#{image_url} shouldn't be invalid"
    end
    bad.each do |image_url|
      assert new_document(image_url).invalid?,
             "#{image_url} shouldn't be valid"
    end
  end
end
