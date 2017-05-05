class PostsController < ApplicationController

    http_basic_authenticate_with name: "maxwell", password: "562450", except: [:index, :show]

    def index
        @posts = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end
    
    def new
        @post = Post.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def create
        @post = Post.new(post_params(:title, :content))
        @post.title = params[:post][:title]
        @post.content = params[:post][:content]
        if @post.save
            redirect_to post_path(@post)
        else
            render 'new'
        end
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params(:title, :content))
            redirect_to post_path(@post)
        else
            render 'edit'
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    private
    def post_params(*args)
        params.require(:post).permit(*args)
    end
end
