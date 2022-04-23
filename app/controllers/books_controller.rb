class BooksController < ApplicationController
	protect_from_forgery except: [:destroy] # CSRF destroyの時はセキュリティトークンの検証を行わない
	before_action :set_book, only: [:show, :destroy]
	around_action :action_logger, only: [:destroy]

	def show
		# renderの記載を省略すると暗黙的にrenderがあるものとして実行される
		# render :show
		# @book = Book.find(params[:id]) # 重複コード
		respond_to do |format|
			format.html
			format.json
		end
	end

	def destroy
		# @book = Book.find(params[:id]) # 重複コード
		@book.destroy
		respond_to do |format|
			format.html { redirect_to "/" }
			format.json { head :no_content }
		end
	end

	private

	def set_book
		@book = Book.find(params[:id])
	end

	def action_logger
		logger.info "around-before"
		yield
		logger.info "around-after"
	end


end
