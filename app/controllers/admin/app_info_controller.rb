class Admin::AppInfoController < AdminController
  before_action :set_info
  def index
    @app_info = AppInfo.first
  end
  
  def update 
    if @app_info.update(app_info_params) 
      redirect_to(admin_path, notice: 'Informações atualizadas com sucesso')
    else 
      render 'edit'
    end
  end

  def show
  end

  private 
    def app_info_params
      params.require(:app_info).permit!
    end
    
    def set_info 
      @app_info = AppInfo.first.present? ? AppInfo.last : AppInfo.new  
    end
end
