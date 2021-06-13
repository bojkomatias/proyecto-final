module CategoriesHelper
  def parent(category)
    if(category.category_id.nil?)
      return 'text-xl font-black'
    else
      return 
    end
  end
end
