# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

    # t.string "title"
    # t.string "category"
    # t.text "description"
  # scrap from restaurant database
    # t.string "tags"
    # t.string "street"
    # t.integer "zipcode"
    # t.string "city"

require 'open-uri'
require 'nokogiri'

puts("Cleaning up database...")
Product.destroy_all
puts("database cleaned")


def fetch_puzzle_urls
  url = "https://www.seriouspuzzles.com/jigsaw-puzzles/"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  puzzles = []
  html_doc.search('.card-figure a').each do |puzzle| #18 on this page
    uri = URI.parse(puzzle.attributes['href'].value)
    puzzles << uri
  end
  puzzles
end

def scrape_puzzle(url)
  html_file = open(url, 'Accept-Language'=>'en').read
  html_doc = Nokogiri::HTML(html_file)
  title = html_doc.search('.productView-title').text
  description = html_doc.search('#tab-description').text
  image = html_doc.search('.productView-image').attribute('data-zoom-image').value


  {title: title, year: year, storyline: storyline, director: director, cast: cast}
end

urls = fetch_puzzle_urls

puzzles = urls.each do |url|
  scrape_puzzle(url)
end
