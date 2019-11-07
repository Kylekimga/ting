class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  after_action :save_my_previous_url, only: [:new, :show]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @profile_check = Post.find_by(current_user_email: current_user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @back_url = session[:my_previous_url]
  end

  # GET /posts/new
  def new
    @post = Post.new
    @back_url = session[:my_previous_url]
  end
  
  def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = URI(request.referer || '').path
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.current_user_email = params[:id]
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '프로필이 성공적으로 등록됐습니다.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '프로필이 성공적으로 수정됐습니다.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:name, :profile_picture, :dateofbirth, :current_user_email)
    end
end
