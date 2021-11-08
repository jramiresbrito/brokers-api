class LoadModelService
  attr_reader :records

  def initialize(searchable_model, params = {})
    @searchable_model = searchable_model
    @params = params || {}
    @records = []
  end

  def call
    @searchable_model = filter_model(@searchable_model, @params)
    @records = paginate_model(@searchable_model, @params)
  end

  private

  def paginate_model(model, params = {})
    model = model.sort! { |a, b| b.created_at <=> a.created_at }
    return Kaminari.paginate_array(model).page(1).per(10) unless params.key?(:page)

    Kaminari.paginate_array(model).page(params[:page][:number]).per(params[:page][:size])
  end

  def filter_model(searchable_model, params = {})
    return searchable_model unless params.key?(:search)

    params[:search].each do |key, value|
      value = value.to_i
      searchable_model = searchable_model.like(key, value)
    end

    searchable_model
  end
end
