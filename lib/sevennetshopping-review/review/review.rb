module SevenNetShoppingReview
  class Review
    def initialize(html)
      @html = html
      @div = html
    end

    def inspect
      "<Review: id=#{id}>"
    end

    def url
      ""
    end

    def user_id
      ""
    end

    def title
      ""
    end

    def date
      unless @date
        match_data = /\((?<year>\d+)年(?<month>\d+)月(?<day>\d+)日登録\)/.match(@html.css('.detail_item_third_status').first.text)
        @date = Date.new(match_data[:year].to_i, match_data[:month].to_i, match_data[:day].to_i)
      end
      @date
    end

    def text
      # remove leading and trailing line returns, tabs, and spaces
      @text ||= @html.css('.detail_review_comment').first.text
    end

    def rating
      @rating ||= Float(@html.css('.detail_item_rank_star_on').first.text.length)
    end

    def helpful_count
      @helpful_count ||= Int(@html.css('.revEntryAnsNum').first.text)
    end

    def to_hash
      attrs = [:url, :user_id, :title, :date, :text, :rating, :helpful_count]
      attrs.inject({}) do |r, attr|
        r[attr] = self.send(attr)
        r
      end
    end

  end
end
