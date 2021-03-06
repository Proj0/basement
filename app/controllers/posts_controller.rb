class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :reply]
  before_action :authenticate_user!
  # paginates_per 10
  load_and_authorize_resource

  # GET /posts
  def index
    @posts = Post.all.includes(:replies)
    @pages = Post.all.order().page(params[:page]).per(10)
    respond_to do |format|  
      format.html
      format.json do
        render json: @posts
      end
    end


  end

  def abc
    @posts = Post.hottest
    render :index
  end


  # GET /posts/1
  def show
    @post.Clicks +=1
    @post.save
    @pages = @post.replies.page(params[:page]).per(10)
  end

  def reply
    reply = @post.replies.create(params[:reply].permit(:body))
    reply.author = current_user
    reply.save
    redirect_to :back, notice: "回复已成功添加。"
  end


  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save

      @post.updated_time_to_sort = Time.zone.now 
      @post.save
      redirect_to @post, notice: '文章已成功发布。'
    else
      render :new
    end

  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      @post.updated_time_to_sort = Time.zone.now 
      @post.save
      redirect_to @post, notice: '文章已成功更新。'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: '文章已成功删除。'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:title, :body)
    end
end
