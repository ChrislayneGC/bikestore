# encoding: utf-8
class Admin::CategoriesController<AdminController

  def index
    @categories =Category.all.page(params[:page]).per(8)
  end

  def new
    @category = Category.new
  end

  def search
    @criteria = params[:search][:criteria]
    criteria = "%#{@criteria}%"
    @result = Category.where('name LIKE ?', criteria).order('name ASC')
    @count = @result.count
    @categories = Kaminari.paginate_array(@result).page(params[:p])
  end

  def show
    @category = Category.friendly.find(params[:id])
    @suppliers = @category.items.collect(&:supplier).uniq
    @suppliers_hash = @suppliers.collect{|s| {"id" => s.id, "name" => s.name, "image" => s.image}}
    @suppliers_hash.each do |h|
      h[:items] = Item.where(category: @category, supplier: h['id']).order(created_at: :desc).map(&:to_api)
      h[:items_count] = h[:items].count
    end
  end


  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Cadastro da categoria #{@category.name} criado com sucesso!"
      redirect_to [:admin, :categories]
    else
      flash[:danger] = "Não foi possível criar o cadastro do categoria #{@category.name}, verifique os campos e tente novamente"
      render 'new'
    end
  end

  def edit
    @category = Category.friendly.find(params[:id])
  end

  def update
    @category = Category.friendly.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "Cadastro da categoria #{@category.name} alterado com sucesso!"
      redirect_to [:admin, :categories]
    else
      flash[:danger] = "Não foi possível atualizar o cadastro do categoria #{@category.name}, tente novamente"
      render 'edit'
    end
  end

  private

  def category_params
    params.require(:category).permit(:id, :name, :active)
  end

end
