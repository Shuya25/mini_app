class TwbooksController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :destroy]
  before_action :correct_user, only: [:destroy]

  def index
    # @user = User.find(params[:id])
    @user = current_user
    @twbook = @user.twbooks.build
    @twbooks = @user.twbooks.paginate(page: params[:page], per_page: 10)
    # render 'list_twbook' # views/twbooks/の中にindexがあるならばそれを自動で見つけてレンダーするので明記する必要はない。
  end

  def create
    @twbook = current_user.twbooks.build(twbook_params)
    @twbook.images.attach(params[:twbook][:image])

    if @twbook.save
      flash[:success] = "Twbook created!"
      redirect_to twbooks_path
    else
      flash[:danger] = "failed created."
      redirect_to twbooks_path
    end
  end

  def destroy
    @twbook.images.purge if @twbook.images.attached? # 削除時にはファイル自体も削除する
    @twbook.destroy
    flash[:success] = "TWBook deleted"
    redirect_to request.referrer || twbooks_path
  end


  private

    def twbook_params
      params.require(:twbook).permit(:content, images:[])
    end

    def correct_user
      @twbook = current_user.twbooks.find_by(id: params[:id])
      redirect_to twbooks_path if @twbook.nil?
    end

end
