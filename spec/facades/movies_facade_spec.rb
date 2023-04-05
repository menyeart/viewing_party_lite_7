require "rails_helper"

RSpec.describe MoviesFacade do
  before :each do
    @facade = MoviesFacade.new(nil)
  end
  describe "#initialize" do
    it "exists" do
      expect(@facade).to be_an_instance_of(MoviesFacade)
    end
  end

  describe "#search_method" do
    it "returns a keyword search or a top rated search on params" do
      VCR.use_cassette("returns_a_keyword_search_or_a_top_rated_search_on_params") do
        facade_1 = MoviesFacade.new(q: "keyword")
        expect(facade_1.search_method).to be_a(Array)
      end
    end

    it "returns a top rated search" do
      VCR.use_cassette("returns_a_json_object") do
        facade_1 = MoviesFacade.new(q: "top_rated")
        expect(facade_1.search_method).to be_a(Array)
      end
    end
  end

  describe "#searched_movies" do
    it "returns new movie objects" do
      VCR.use_cassette("can_search_for_movies_by_key_word") do
        facade_1 = MoviesFacade.new(nil)

        movies = facade_1.searched_movies("god")
        expect(movies.count).to eq(20)
        expect(movies.first).to be_an_instance_of(Movie)
      end
    end
  end

  describe "#get_details" do
    before :each do
      @facade_1 = MoviesFacade.new(238)
    end
    it "returns a json object" do
      VCR.use_cassette("movie_details") do
        the_godfather = @facade_1.get_details

        expect(the_godfather).to be_a(Hash)
        expect(the_godfather[:original_title]).to eq("The Godfather")
      end
    end

    it "#runtime" do
      VCR.use_cassette("movie_details") do
        movie_runtime = @facade_1.runtime(238)

        expect(movie_runtime).to be_a(Integer)
        expect(movie_runtime).to eq(175)
      end
    end

    it "#title" do
      VCR.use_cassette("movie_details") do
        movie_title = @facade_1.title(238)

        expect(movie_title).to be_a(String)
        expect(movie_title).to eq("The Godfather")
      end
    end

    it "#vote_average" do
      VCR.use_cassette("movie_details") do
        movie_vote_average = @facade_1.vote_average(238)

        expect(movie_vote_average).to be_a(Float)
        expect(movie_vote_average).to eq(8.711)
      end
    end

    it "#summary" do
      VCR.use_cassette("movie_details") do
        movie_summary = @facade_1.summary(238)

        expect(movie_summary).to be_a(String)
      end
    end

    it "#get_genres" do
      VCR.use_cassette("movie_details") do
        movie_summary = @facade_1.get_genres(238)

        expect(movie_summary).to be_a(Array)
      end
    end
  end

  describe "#get_reviews" do
    it "returns reviews for a single movie" do
      VCR.use_cassette("returns_a_json_object_containing_a_movies_reviews") do
        facade = MoviesFacade.new(238)
        reviews = facade.get_reviews(238)

        expect(reviews).to be_a(Array)
        expect(reviews.count).to eq(3)
      end
    end
  end

  describe "#get_review_count" do
    it "returns the count of reviews for a single movie" do
      VCR.use_cassette("returns_a_json_object_containing_a_movies_reviews") do
        facade = MoviesFacade.new(238)
        review_count = facade.get_review_count(238)

        expect(review_count).to be_a(Integer)
        expect(review_count).to eq(3)
      end
    end
  end

  describe "#get_cast" do
    it "it returns the first ten cast members for a single movie" do
      VCR.use_cassette("returns_a_json_objects_containing_movie_credits") do
        facade = MoviesFacade.new(238)
        cast = facade.get_cast(238)

        expect(cast).to be_a(Array)
        expect(cast.count).to eq(10)
      end
    end
  end

  describe "#detailed_movie" do
    it "returns a new movie object with all details", :vcr do
      facade = MoviesFacade.new(238)
      movie_details = facade.detailed_movie

      expect(movie_details).to be_an_instance_of(Movie)
      expect(movie_details.cast).to be_a(Hash)
      expect(movie_details.genres).to be_a(Array)
      expect(movie_details.genres).to be_a(Array)
      expect(movie_details.movie_id_show).to be_a(Integer)
      expect(movie_details.review_info).to be_a(Hash)
      expect(movie_details.runtime).to be_a(Integer)
      expect(movie_details.summary).to be_a(String)
      expect(movie_details.total_review_count).to be_a(Integer)
      expect(movie_details.title_show).to be_a(String)
      expect(movie_details.vote_average_show).to be_a(Float)
      expect(movie_details.poster_path).to be_a(String)
    end
  end
end
