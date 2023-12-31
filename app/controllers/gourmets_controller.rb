class GourmetsController < ApplicationController
  before_action :authenticate_user!, only: [:top, :index, :new, :create]
  
  def top
  end

  def index
    @gourmets = Gourmet.all
      if params[:search] == nil
      @gourmets = params[:tag_id].present? ? Tag.find(params[:tag_id]).gourmets : Gourmet.all
      elsif params[:search] == ''
      @gourmets = params[:tag_id].present? ? Tag.find(params[:tag_id]).gourmets : Gourmet.all
      else
      @gourmets = Gourmet.where("storename LIKE ? OR menu LIKE ? OR place LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
      end
    @gourmets = @gourmets.page(params[:page]).per(3)

  end
  

  def new
    @gourmet = Gourmet.new
  end
    
  def create
    gourmet = Gourmet.new(gourmet_params)
    gourmet.user_id = current_user.id
    if gourmet.save!
        redirect_to :action => "index"
    else
          redirect_to :action => "new"
    end
  end

  def show
    @gourmet = Gourmet.find_by(id: params[:id])
    @comments = @gourmet.comments
    @comment = Comment.new
  end

  def edit
    @gourmet = Gourmet.find(params[:id])
  end

  def update
    gourmet = Gourmet.find(params[:id])
      if gourmet.update(gourmet_params)
        redirect_to :action => "show", :id => gourmet.id
      else
      redirect_to :action => "new"
      end
  end
    
  def destroy
    gourmet = Gourmet.find(params[:id])
    gourmet.destroy
    redirect_to action: :index
  end

  def Hokkaido
    @Hokkaido = Gourmet.where(prefecture:"北海道")
  end
      
  def Tokyo
    @Tokyo = Gourmet.where(prefecture:"東京")
  end
      
  def Osaka
    @Osaka = Gourmet.where(prefecture:"大阪")
  end

  def Fukuoka
    @Fukuoka = Gourmet.where(prefecture:"福岡")
  end

  def Ginghiskhan
    @Ginghiskhan = Gourmet.where(food:"ジンギスカン")
    @Ginghiskhan = @Ginghiskhan.page(params[:page]).per(6)
  end

  def Kaisendon
    @Kaisendon = Gourmet.where(food:"海鮮丼")
    @Kaisendon = @Kaisendon.page(params[:page]).per(6)
  end

  def Sappororamen
    @Sappororamen = Gourmet.where(food:"札幌ラーメン")
    @Sappororamen = @Sappororamen.page(params[:page]).per(6)
  end

  def Hokkaidoelse
    @Hokkaidoelse = Gourmet.where(food:"その他(北海道)")
    @Hokkaidoelse = @Hokkaidoelse.page(params[:page]).per(6)
  end

  def Edomaezushi
    @Edomaezushi = Gourmet.where(food:"江戸前寿司")
    @Edomaezushi = @Edomaezushi.page(params[:page]).per(6)
  end

  def Monzyayaki
    @Monzyayaki = Gourmet.where(food:"もんじゃ焼き")
    @Monzyayaki = @Monzyayaki.page(params[:page]).per(6)
  end

  def Chankonabe
    @Chankonabe = Gourmet.where(food:"ちゃんこ鍋")
    @Chankonabe = @Chankonabe.page(params[:page]).per(6)
  end

  def Tokyoelse
    @Tokyoelse = Gourmet.where(food:"その他(東京)")
    @Tokyoelse = @Tokyoelse.page(params[:page]).per(6)
  end

  def Takoyaki
    @Takoyaki = Gourmet.where(food:"たこ焼き")
    @Takoyaki = @Takoyaki.page(params[:page]).per(6)
  end

  def Okonomiyaki
    @Okonomiyaki = Gourmet.where(food:"お好み焼き")
    @Okonomiyaki = @Okonomiyaki.page(params[:page]).per(6)
  end

  def Kushikatu
    @Kushikatu = Gourmet.where(food:"串カツ")
    @Kushikatu = @Kushikatu.page(params[:page]).per(6)
  end

  def Osakaelse
    @Osakaelse = Gourmet.where(food:"その他(大阪)")
    @Osakaelse = @Osakaelse.page(params[:page]).per(6)
  end

  def Motunabe
    @Motunabe = Gourmet.where(food:"もつ鍋")
    @Motunabe = @Motunabe.page(params[:page]).per(6)
  end

  def Hakataramen
    @Hakataramen = Gourmet.where(food:"博多ラーメン")
    @Hakataramen = @Hakataramen.page(params[:page]).per(6)
  end

  def Mizutaki
    @Mizutaki = Gourmet.where(food:"水炊き")
    @Mizutaki = @Mizutaki.page(params[:page]).per(6)
  end

  def Fukuokaelse
    @Fukuokaelse = Gourmet.where(food:"その他(福岡)")
    @Fukuokaelse = @Fukuokaelse.page(params[:page]).per(6)
  end

  private
    def gourmet_params
      params.require(:gourmet).permit(:prefecture, :food, :shop_name, :about_shop, :price, :addres, :image, :tag_ids, :overall, :level, :lat, :lng)
    end
end