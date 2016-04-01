class PostrepliesController < ApplicationController
  before_action :set_postreply, only: [:show, :edit, :update, :destroy]

  # GET /postreplies
  # GET /postreplies.json
  def index
    @postreplies = Postreply.all
  end

  # GET /postreplies/1
  # GET /postreplies/1.json
  def show
  end

  # GET /postreplies/new
  def new
    @postreply = Postreply.new
  end

  # GET /postreplies/1/edit
  def edit
  end

  # POST /postreplies
  # POST /postreplies.json
  def create
    @postreply = Postreply.new(postreply_params)

    respond_to do |format|
      if @postreply.save
        post = Post.find(id=@postreply.post_id)
        forum = Forum.find(id=post.forum_id)

        format.html { redirect_to forum_post_path(forum, post)}
        format.json { render :show, status: :created, location: @postreply }
      else
        format.html { render :new }
        format.json { render json: @postreply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /postreplies/1
  # PATCH/PUT /postreplies/1.json
  def update
    respond_to do |format|
      if @postreply.update(postreply_params)
        format.html { redirect_to @postreply, notice: 'Postreply was successfully updated.' }
        format.json { render :show, status: :ok, location: @postreply }
      else
        format.html { render :edit }
        format.json { render json: @postreply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postreplies/1
  # DELETE /postreplies/1.json
  def destroy
    @postreply.destroy
    respond_to do |format|
      format.html { redirect_to postreplies_url, notice: 'Postreply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postreply
      @postreply = Postreply.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postreply_params
      params.require(:postreply).permit(:content, :user_id, :post_id)
    end
end
