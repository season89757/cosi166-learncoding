class SearchBoxController < ApplicationController
  def search_results
    terms = params[:terms].split(" ")
    @results = []
    for term in terms
        @results.concat Book.where("title like ?", "%#{term}%")
        @results.concat Book.where("description like ?", "%#{term}%")
    end
  end
end
