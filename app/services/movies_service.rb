require "faraday"
class MoviesService
  def self.connection
    url = "https://api.themoviedb.org"
    Faraday.new(url: url, headers: { "Authorization" => "Bearer #{ENV['movie_token']}" })
  end

  def self.parse_api(arg)
    response = connection.get("#{arg}")
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.searched_movies(title)
    parse_api("/3/search/movie?&query=#{title}")
  end

  def self.top_rated_movies
    parse_api("/3/movie/top_rated")
  end

  def self.movie_details(id)
    parse_api("/3/movie/#{id}")
  end

  def self.credits(id)
    parse_api("/3/movie/#{id}/credits")
  end

  def self.reviews(id)
    parse_api("/3/movie/#{id}/reviews")
  end
end
