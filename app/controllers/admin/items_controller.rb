# encoding: utf-8
class Admin::ItemsController<AdminController

  def index
    @items = Item.all.order(created_at: :asc).page(params[:page]).per(10)
    @categories = Category.all
    @subcategories =  Subcategory.all
  end

  def new
    @item = Item.new
    @categories = Category.all
    @subcategories =  Subcategory.all
  end

  def search
    @criteria = params[:search][:name]
    criteria = "%#{@criteria}%"
    @result = Item.where('name LIKE ?', criteria).order('name ASC')
    @count = @result.count
    @items = Kaminari.paginate_array(@result).page(params[:p])
  end

  def show
    @item = Item.friendly.find(params[:id])
  end

	def create
		# params[:item][:price] =  params[:item][:price].gsub(",",".")
		# params[:item][:weight] = params[:item][:weight].gsub(",",".")
		# params[:item][:height] = params[:item][:height].gsub(",",".")
		# params[:item][:length] = params[:item][:length].gsub(",",".")
		# params[:item][:width] = params[:item][:width].gsub(",",".")

    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Cadastro do produto #{@item.name} criado com sucesso!"
      redirect_to [:admin, :items]
    else
      flash[:danger] = "Não foi possível criar o produto #{@item.name}, verifique os campos e tente novamente"
      render 'new'
    end
  end

  def edit
    @item = Item.friendly.find(params[:id])
  end

  def update
    @item = Item.friendly.find(params[:id])
    # params[:item][:price] =  params[:item][:price].gsub(",",".")
    # params[:item][:weight] = params[:item][:weight].gsub(",",".")
    # params[:item][:height] = params[:item][:height].gsub(",",".")
    # params[:item][:length] = params[:item][:length].gsub(",",".")
    # params[:item][:width] = params[:item][:width].gsub(",",".")
    if @item.update_attributes(item_params)
      flash[:notice] = "Cadastro do produto #{@item.name} alterado com sucesso!"
      # redirect_to [:admin, :items]
      @items = Item.all.page(params[:page]).per(10)
      redirect_to [:admin, :items]
    else
      flash[:danger] = "Não foi possível atualizar o cadastro do produto #{@item.name}, tente novamente"
      render 'edit'
    end
  end

  private

  def item_params
    params.require(:item).permit(:id, :quantity, :code, :text, :subcategory_id, :name, :length, :price, :weight, :height, :width, :description, :active, :highlight,:image, images_attributes: [:id, :image, :_destroy])
  end

  def search_params
    params.require(:search).permit(:name, :subcategory_id)
  end

end
