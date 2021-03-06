
class Book < ActiveRecord::Base
  validates :ISBN, presence: true, uniqueness: true
  has_many :users, :through => :comments
  has_many :comments
  has_many :domains
  has_many :languages

  def self.terms_table()
    return {
        'Web Development' => 'rails django flask javascript jquery server node angular meteor express mvc',

        'Databases' => 'sql mysql postgres mongo mongodb',

        'Data Structures + Algorithms' => 'algorithm structures',

        'Security' => 'security crypto',

        'Introductory' => 'introduction introductory beginner',

        'Testing' => 'testing',

        'Networking' => 'networking',

        'Theory' => 'theory theoretical',

        'Python' => 'python',

        'Ruby' => 'ruby',

        'Java' => 'java',

        'C++' => 'c++',

        'PHP' => 'php',

        'Javascript' => 'javascript'
    }

end

  # Helper Function---NOT A VIEW
  def self.add_item_to_hash(book, score, hash)
    # adds/updates an item in a hash with a particular score
    if hash.key?(book)
        hash[book] += score
    else
        hash[book] = score
    end
  end

  def self.num_times_substring_appears(substring, string)
    string.scan(/(?= #{substring} )/).count
  end

  def self.run_search(query_string, tag=nil)
# Controller for the resutls from a user search.
    # INPUT:
    #   query_string: which holds a search query
    #   tag: domain within which to search (See Tag model)
    # RETURN:
    #   @results variable to the view. @results is an array of Book
    #   objects for consumption in the view.

    # hashes stopwords for O(1) access. The 1 (value) is meaningless.
    stopwords = {'all'=> 1, 'just'=> 1, 'being'=> 1, 'over'=> 1, 'both'=> 1, 'through'=> 1,
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


    # removes punctuation and split
    rawterms = query_string.tr(',.', '')
    rawterms = rawterms.split(" ")

    terms = []

    # remove stopwords from terms
    for term in rawterms
        unless stopwords.has_key?(term.downcase) then terms.push(term.downcase) end
    end

    # in case there are no meaningful terms, use the original ones
    if terms.empty?
        unless rawterms.empty?
            terms = rawterms
        else
            terms = "meaningful search terms".split(' ')
        end
    end

    processed_query_string = terms.join(' ')

    # Using three loops crudely ranks the results on which
    # column is being searched.

    results_scores = Hash.new

    # adds tags terms to query for ranking purposes
    unless tag == nil or tag == 'Any Topic'
        terms_table = terms_table()
        terms_for_tag = terms_table[tag]
        terms.push(terms_for_tag.split(' '))
    end

    # begin scoring
    for term in terms

        # search by title
        for book in Book.where("lower(title) like ?", "%#{term}%")
            score = 100 * num_times_substring_appears(term, book.title)
            add_item_to_hash(book, score, results_scores)
        end

        # search by description
        for book in Book.where("lower(description) like ?", "%#{term}%")
            score = 1 * num_times_substring_appears(term, book.description)
            add_item_to_hash(book, score, results_scores)
        end

        # search by author
        for book in Book.where("lower(author) like ?", "%#{term}%")
            score = 1 * num_times_substring_appears(term, book.author)
            add_item_to_hash(book, score, results_scores)
        end
    end

    # if there's a specific tag, then filter results 
    unless tag == nil or tag == 'Any Topic'
        books_in_hash = results_scores.keys
        books_in_hash.each do |book|
            if not Tag.where('name = :tag AND book_id = :bookid', {tag: tag, bookid: book.id}).exists?
                results_scores.delete(book)
            end
        end
    end

    # use rating information
    results_scores.keys.each do |book|
        results_scores[book] += book.average_rating.to_i * 5
    end

    # get hash results sorted by score
    results = results_scores.keys.sort {|a, b| results_scores[b] <=> results_scores[b]}
    # deduplicates the list

    #results = results.uniq

    return results
  end

end
