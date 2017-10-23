class FetchActiveEmployees
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10

  def self.call(params)
    self.new(params).call
  end

  def initialize(params)
    @params = params
  end

  def call
    scope = default_scope.where(emp_no: active_employee_nos)
    scope.paginate(page: page, per_page: per_page)
  end

  private
  attr_reader :params, :dept_no

  def default_scope
    Employee.includes(:departments, :titles, :salaries)
  end

  def page
    params[:page] || DEFAULT_PAGE
  end

  def per_page
    params[:per_page] || DEFAULT_PER_PAGE
  end

  def dept_no
    params[:dept_no]
  end

  def employee_stats 
    @employee_stats ||= SeekEmployeeStats.call(dept_no)
  end

  def active_employee_nos
    return [] if employee_stats.empty?
    employee_stats.select do |stat|
      stat[:clicks] > 0 && stat[:views] > 0
    end.pluck(:emp_no)
  end
end
