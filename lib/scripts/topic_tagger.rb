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

