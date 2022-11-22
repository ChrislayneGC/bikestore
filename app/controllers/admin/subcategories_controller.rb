# encoding: utf-8
class Admin::SubcategoriesController<AdminController

  def index
    @subcategories =Subcategory.all.page(params[:page]).per(8)
  end

  def new
    @subcategory = Subcategory.new
  end

  def search
    @criteria = params[:search][:criteria]
    criteria = "%#{@criteria}%"
    @result = Subcategory.where('name LIKE ?', criteria).order('name ASC')
    @count = @result.count
    @subcategories = Kaminari.paginate_array(@result).page(params[:p])
  end

  def show
    @subcategory = Subcategory.friendly.find(params[:id])
    @suppliers = @subcategory.items.collect(&:supplier).uniq
    @suppliers_hash = @suppliers.collect{|s| {"id" => s.id, "name" => s.name, "image" => s.image}}
    @suppliers_hash.each do |h|
      h[:items] = Item.where(subcategory: @subcategory, supplier: h['id']).order(created_at: :desc).map(&:to_api)
      h[:items_count] = h[:items].count
    end
  end


  def create
    @subcategory = Subcategory.new(subcategory_params)
    if @subcategory.save
      flash[:notice] = "Cadastro da categoria #{@subcategory.name} criado com sucesso!"
      redirect_to [:admin, :subcategories]
    else
      flash[:danger] = "Não foi possível criar o cadastro do categoria #{@subcategory.name}, verifique os campos e tente novamente"
      render 'new'
    end
  end

  def edit
    @subcategory = Subcategory.friendly.find(params[:id])
  end

  def update
    @subcategory = Subcategory.friendly.find(params[:id])
    if @subcategory.update_attributes(subcategory_params)
      flash[:notice] = "Cadastro da categoria #{@subcategory.name} alterado com sucesso!"
      redirect_to [:admin, :subcategories]
    else
      flash[:danger] = "Não foi possível atualizar o cadastro do categoria #{@subcategory.name}, tente novamente"
      render 'edit'
    end
  end

  private

  def subcategory_params
    params.require(:subcategory).permit(:id, :name, :active, :category_id)
  end

end
