class FetchEmployees
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def self.call(params = {})
    self.new(params).call
  end

  def initialize(params = {})
    @params = params
  end

  def call
    scope = default_scope

    if salary_criteria?
      scope = scope.where('salaries.salary >= ?', params[:salary_from]) if params[:salary_from]
      scope = scope.where('salaries.salary <= ?', params[:salary_to]) if params[:salary_to] 
      scope = scope.references(:salaries)
    end

    scope.paginate(page: page, per_page: per_page)
  end

  private
  attr_reader :params

  def default_scope
    Employee.includes(:departments, :titles, :salaries)
  end

  def page
    params[:page] || DEFAULT_PAGE
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def salary_criteria?
    !!(params[:salary_from] || params[:salary_to])
  end
end
