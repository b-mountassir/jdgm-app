class MoviesController < ApplicationController

    def index
      begin
        res = RestClient.get("https://api.themoviedb.org/3/movie/popular",
                             { params: {
                               api_key: ENV['MOVIE_API_KEY'],
                               page: get_page
                             }})
        data = JSON.parse(res.body, symbolize_names: true)
        @movies = data[:results]
        @page = data[:page]
        @total_pages = data[:total_pages]
      rescue => e
        puts e, "-----"
        render "layouts/404" and return
      end
    end
  
    def show
      begin
        res = RestClient.get("https://api.themoviedb.org/3/movie/#{params[:id]}" , { params: { api_key: ENV['MOVIE_API_KEY'] }})
        @movie = JSON.parse(res.body, symbolize_names: true)
      rescue => e 
        puts e, "-----"
        render "layouts/404" and return
      end
    end
    
    def search
      if params[:query].nil?
        redirect_to  root_url and return
      end
  
      begin
        res = RestClient.get("https://api.themoviedb.org/3/search/movie#{params[:id]}" ,
                             { params: {
                               api_key: ENV['MOVIE_API_KEY'],
                               query: params[:query],
                               page: get_page
                             }})
        data = JSON.parse(res.body, symbolize_names: true)
        @movies = data[:results]
        @page = data[:page]
        @total_pages = data[:total_pages]
      rescue => e  # catch all exceptions includes: network error, response err, json parse exception
        puts e, "-----"
        render "layouts/404" and return
      end
      # simple_form
  
    end

    private
    def set_page
      @page = !params[:page].nil? ? params[:page] : 1
    end
  
    def get_page
      !params[:page].nil? ? params[:page] : 1
    end
  
  end