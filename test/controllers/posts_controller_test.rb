require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @forum_one  = Forum.create(name: "Linguistic Theory")
    @post_one_title = "Does syntax exist separate from semantics?"
    @post_one_content = "Colorless green ideas sleep furiously."
    @post_one = Post.create(title: @post_one_title, 
                            content: @post_one_content,
                            forum_id: @forum_one.id)
    @postreply_one = Postreply.create(content: "Gnome Chomp Ski", 
                                      post_id: @post_one.id)
    @postreply_two = Postreply.create(content: "Second post", 
                                      post_id: @post_one.id)

  end

  test "should save title and content of post" do
    assert_equal @post_one.title, @post_one_title
    assert_equal @post_one.content, @post_one_content
  end

  # might logically go in the forums tests, but I think it makes sense here
  test "forum should have all posts" do
    assert_equal @forum_one.posts.length, 1
  end

  test "posts should have all postreplies" do 
    assert_equal @post_one.postreplies.length, 2
  end

  test "postreplies are loaded in order" do
    assert_equal @post_one.postreplies[0], @postreply_one
    assert_equal @post_one.postreplies[1], @postreply_two
  end

end
