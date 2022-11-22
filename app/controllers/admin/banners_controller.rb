class Admin::BannersController < AdminController
  before_action :set_banner, :except => [:create, :new, :index]
  def create
    
    @banner = Banner.new(banner_params)
    if !@banner.image.nil?
      if @banner.save
        redirect_to(admin_banners_path)
      else
        render 'new'
        flash[:notice] = "Selecione uma imagem"
      end 
    else
      flash[:notice] = "Selecione uma imagem"
    end
  end

  def new
    @banner = Banner.new
  end

  def index 
    @banners = Banner.all
  end
 
  
  def update
    @banner = Banner.find(params[:id])
    if @banner.update(banner_params)
      redirect_to(admin_banners_path, notice: 'Banner atualizado com sucesso')
    else
      render 'edit'   
    end
  end

  def set_banner
    @banner = Banner.find(params[:id])
  end
  
  private
    def banner_params
      params.require(:banner).permit(:id, :active, :image)
    end
end
