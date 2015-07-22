require 'nokogiri'
require 'open-uri'
require_relative "review/version"
require_relative 'review/review'

module SevenNetShoppingReview
  def self.find_reviews(url)
    reviews = []
    delay = 0.5
    page = 1

    # iterate through the pages of reviews

    begin
      match_data /.*accd\/(?<product_id>[^\/]+).*/.match(url)
      product_id = match_data[:product_id]
      url = "http://www.7netshopping.jp/books/detail/review/-/accd/#{product_id}/subno/1/lst/1"
      html = open(url).read.encode("UTF-8")
      doc = Nokogiri::HTML.parse(html)
      doc.css(".detail_64component_left").each do |review_html|
        reviews <<  Review.new(review_html)
      end
      # go to next page
      break

    rescue Exception => e # error while parsing (likely a 503)
      delay += 0.5 # increase delay

    end until new_reviews == 0

    reviews
  end
end
