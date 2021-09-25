class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'partial_match'
        User.where('name LIKE ?', '%'+content+'%')
      elsif method == "forward_match"
        User.where('name LIKE ?', '%'+content+'%')
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    elsif model == 'post'
      if method == 'perfect'
        Post.where(title: content)
      elsif method == 'partial_match'
        Post.where('title LIKE ?', '%'+content+'%')
      elsif method == 'forward_match'
        Post.where('title LIKE ?', '%'+content+'%')
      else
        Post.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
