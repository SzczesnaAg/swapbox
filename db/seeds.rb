# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'open-uri'
require 'nokogiri'

puts("Cleaning up database...")
Review.destroy_all
Message.destroy_all
Swap.destroy_all
Product.destroy_all
User.destroy_all
puts("database cleaned")

puts("Winter is coming")
sansa = User.new(email: "sansa@north.com", last_name: "Stark", first_name: "Sansa", password: "123456")
sansa.photo.attach(io: File.open(Rails.root.join("app/assets/images/sansa.png")), filename: "sansa.png")
sansa.save!

arya = User.new(email: "arya@north.com", last_name: "Stark", first_name: "Arya", password: "123456")
arya.photo.attach(io: File.open(Rails.root.join("app/assets/images/arya.png")), filename: "arya.png")
arya.save!

jon = User.new(email: "jon@north.com", last_name: "Stark", first_name: "Jon", password: "123456")
jon.photo.attach(io: File.open(Rails.root.join("app/assets/images/jon.png")), filename: "jon.png")
jon.save!

robb = User.new(email: "robb@north.com", last_name: "Stark", first_name: "Robb", password: "123456")
robb.photo.attach(io: File.open(Rails.root.join("app/assets/images/robb.png")), filename: "robb.png")
robb.save!

puts ("The North remembers")

def fetch_puzzle_urls(url)
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  puzzles = []
  html_doc.search('.card-figure a').each do |puzzle| #18 on this page
    uri = URI.parse(puzzle.attributes['href'].value)
    puzzles << uri
  end
  puzzles
end

def get_addresses
  url = "https://tel.search.ch/?was=Restaurant+&pages=9" #90 addresses here
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.tel-address').map do |address|
    street = address.text.split(',')[0]
    zipcode = address.text.split(',')[1].split[0]
    city = address.text.split(',')[1].split[1]
    {street: street, zipcode: zipcode, city: city}
  end
end

def scrape_puzzle(url, address)
  html_file = open(url, 'Accept-Language'=>'en').read
  html_doc = Nokogiri::HTML(html_file)
  title = html_doc.search('.productView-title').text
  description = html_doc.search('#tab-description').text
  image = html_doc.search('.productView-image').attribute('data-zoom-image').value

  product = Product.new(
    title: title,
    category: "Puzzle",
    description: description,
    street: address[:street],
    zipcode: address[:zipcode],
    city: address[:city],
    user: User.all.sample
    )
  file = URI.open(image)
  product.photo.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  product.save!
end

url_one = fetch_puzzle_urls("https://www.seriouspuzzles.com/jigsaw-puzzles/")
url_two = fetch_puzzle_urls("https://www.seriouspuzzles.com/jigsaw-puzzles/?sort=bestselling&page=2")

addresses = get_addresses
book_addresses = addresses.reverse

puzzles = url_one.each_with_index do |url, index|
  scrape_puzzle(url, addresses[index])
end

puzzles = url_two.each_with_index do |url, index|
  scrape_puzzle(url, addresses[index])
end

puts "Puzzles created"
puts "Scraping books"

def scrape_books(index, address)
  url = "https://www.nytimes.com/books/best-sellers/" #has 55 books
  html_file = open(url, 'Accept-Language'=>'en').read
  html_doc = Nokogiri::HTML(html_file)
  books = []
  book_title = html_doc.search('.css-i1z3c1')[index].text
  book_author = html_doc.search('.css-1nxjbfc')[index].text
  title = book_title + ' ' + book_author
  description = html_doc.search('.css-5yxv3r')[index].text
  image = html_doc.search('.css-35otwa')[index].attribute('src').value
  books << {title: title, description: description, image: image}

  product = Product.new(
  title: title,
  category: "Book",
  description: description,
  street: address[:street],
  zipcode: address[:zipcode],
  city: address[:city],
  user: User.all.sample
  )
  file = URI.open(image)
  product.photo.attach(io: file, filename: 'nes.jpg', content_type: 'image/jpg')
  product.save!
end

books = book_addresses.each_with_index do |address, index|
  scrape_books(index, address) unless index > 40
end

puts "Books created"
