class SearchBoxController < ApplicationController
  def search_results

    # TODO
    # truncate results? at a certain length?
    # search results bug with multiple terms - see failing test

    # hashes stopwords for O(1) access. The 1 (value) is meaningless.
    @stopwords = {'all'=> 1, 'just'=> 1, 'being'=> 1, 'over'=> 1, 'both'=> 1, 'through'=> 1,
        'yourselves'=> 1, 'its'=> 1, 'before'=> 1, 'herself'=> 1, 'had'=> 1, 'should'=> 1,
        'to'=> 1, 'only'=> 1, 'under'=> 1, 'ours'=> 1, 'has'=> 1, 'do'=> 1, 'them'=> 1,
        'his'=> 1, 'very'=> 1, 'they'=> 1, 'not'=> 1, 'during'=> 1, 'now'=> 1, 'him'=> 1,
        'nor'=> 1, 'did'=> 1, 'this'=> 1, 'she'=> 1, 'each'=> 1, 'further'=> 1,
        'where'=> 1, 'few'=> 1, 'because'=> 1, 'doing'=> 1, 'some'=> 1, 'are'=> 1,
        'our'=> 1, 'ourselves'=> 1, 'out'=> 1, 'what'=> 1, 'for'=> 1, 'while'=> 1,
        'does'=> 1, 'above'=> 1, 'between'=> 1, 't'=> 1, 'be'=> 1, 'we'=> 1, 'who'=> 1,
        'were'=> 1, 'here'=> 1, 'hers'=> 1, 'by'=> 1, 'on'=> 1, 'about'=> 1, 'of'=> 1,
        'against'=> 1, 's'=> 1, 'or'=> 1, 'own'=> 1, 'into'=> 1, 'yourself'=> 1, 'down'=> 1,
        'your'=> 1, 'from'=> 1, 'her'=> 1, 'their'=> 1, 'there'=> 1, 'been'=> 1, 'whom'=> 1, '
        too'=> 1, 'themselves'=> 1, 'was'=> 1, 'until'=> 1, 'more'=> 1, 'himself'=> 1,
        'that'=> 1, 'but'=> 1, 'don'=> 1, 'with'=> 1, 'than'=> 1, 'those'=> 1, 'he'=> 1,
        'me'=> 1, 'myself'=> 1, 'these'=> 1, 'up'=> 1, 'will'=> 1, 'below'=> 1, 'can'=> 1,
        'theirs'=> 1, 'my'=> 1, 'and'=> 1, 'then'=> 1, 'is'=> 1, 'am'=> 1, 'it'=> 1, 'an'=> 1,
        'as'=> 1, 'itself'=> 1, 'at'=> 1, 'have'=> 1, 'in'=> 1, 'any'=> 1, 'if'=> 1,
        'again'=> 1, 'no'=> 1, 'when'=> 1, 'same'=> 1, 'how'=> 1, 'other'=> 1, 'which'=> 1,
        'you'=> 1, 'after'=> 1, 'most'=> 1, 'such'=> 1, 'why'=> 1, 'a'=> 1, 'off'=> 1, 'i'=> 1,
        'yours'=> 1, 'so'=> 1, 'the'=> 1, 'having'=> 1, 'once'=> 1}


    @original_query_string = params[:terms]

    # removes punctuation and split
    @rawterms = @original_query_string.tr(',.', '')
    @rawterms = @rawterms.split(" ")

    @terms = []

    # remove stopwords from terms
    for term in @rawterms
        unless @stopwords.has_key?(term.downcase) then @terms.push(term.downcase) end
    end

    # in case there are no meaningful terms, use the original ones
    if @terms.empty?
        unless @rawterms.empty?
            @terms = @rawterms
        else
            @terms = "meaningful search terms".split(' ')
        end
    end

    @processed_query_string = @terms.join(' ')

    # Using three loops crudely ranks the results on which
    # column is being searched.
    @results = Book.where("lower(title) like ?", "%#{@terms[0]}%")
    for term in @terms[1..-1]
        @results += Book.where("lower(title) like ?", "%#{term}%")
    end
    for term in @terms
        @results += Book.where("lower(author) like ?", "%#{term}%")
    end
    for term in @terms
        @results += Book.where("lower(description) like ?", "%#{term}%")
    end
    #deduplicates the list
    @results = @results.uniq
  end
end
