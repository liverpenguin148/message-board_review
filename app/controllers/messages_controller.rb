class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end
  
  def show
    @message = Message.find(params[:id]) # params: Railsで送られてきた値を受け取るためのメソッド
  end
  
  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_param)
    if @message.save
      flash[:success] = 'Massage が正常に投稿されました' # flashハッシュのため、{success: 'Massage が正常に投稿されました'}
      redirect_to @message # @messageのshowルーティング(/messages/:id)へ飛ぶ
    else
      flash.now[:danger]  = 'Messageが投稿されませんでした'
      render :new # messages/new.html.erbを表示する
    end  
  end
  # ===== redirect_to と render の違い ====
  # redirect_to @message は処理を showのアクションへと強制的に移動させる
  # ⇒ 今回の場合では、createアクションを実行後、さらにshowアクションが行われることになる
  # render :new は単純にmessages/new.html.erbを表示するだけ(newアクションは行わない)
  #
  
  def edit
    @message = Message.find(params[:id])
  end
  
  def update
    @message = Message.find(params[:id])
    if @message.update(message_param)
      flash[:success] = 'Massage が正常に投稿されました'
      redirect_to @message
    else
      flash.now[:danger]  = 'Messageが投稿されませんでした'
      render :edit
    end
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = 'Massage が正常に削除されました'
    redirect_to messages_url
  end
  
  private
  # Strong Parameter作成
  # params.require(:message) ⇒  messageeの値が取得
  # .permit(:content) ⇒  message.content の値を取得
  def message_param
    params.require(:message).permit(:content)
  end
end
