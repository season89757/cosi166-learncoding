# This script performs ActiveRecord searches for some topics and applies appropriate
# tags to the books. 

# Each topic is defined by a set of keywords. If a search for that keyword
# returns a book, that book is said to be related to that topic. 

# A tag is a database row that associates a string tag (ie: 'web development')
# with a book id.

# A book may have multiple tags, but not two of the same tag

# IMPORTANT!!! Each time this script runs, it will clear ALL existing tags
# and create new ones. This is because our books may be deleted/recreated 
# soon, and I don't want there to be tags pointing to books that don't exist. 


# External-facing method. Call this to run the script. 
def run_tag_script()
    puts "Beginning the tag process."
    
    clear_all_tags()
    terms_table = terms_table()

    terms_table.each do |tag, terms|

        relevant_books = run_query(terms)
        tag_books(tag, relevant_books)
    
    end
    puts "The tagging process is now complete."
end


### INTERNAL METHODS ###

# returns a hash of tag_name: [terms]
def terms_table()
    return {
        'Web Development' => ['rails', 'django', 'flask', 
                                'javascript', 'jquery', 'server', 
                                'node', 'angular', 'meteor', 
                                'express', 'mvc'],

        'Databases' =>      ['sql', 'mysql', 'postgres', 'mongo', 
                                'mongodb'],

        'Data Structures + Algorithms' => ['algorithm', 'structures'],

        'Security' =>       ['security', 'crypto'],

        'Introductory' =>   ['introduction', 'introductory', 'beginner', 
                                'basic'],
        'python' => ['django', 'python']
    }

end

# returns a list of books matching the terms. Terms is an array
def run_query(terms)

    # refactor existing search, perhaps

end

# creates tags for books. 
def tag_books(tag, books)

    # be sure to avoid duplicates!!

end

# Deletes all tags currently existing in the database. 
def clear_all_tags()
    puts "Deleting Tags..."
    Tag.delete_all()
    puts "Finished deleting all tags."
end
