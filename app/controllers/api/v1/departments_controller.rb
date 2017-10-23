class Api::V1::DepartmentsController < ApplicationController
  def active_employees
    if params_sanitizer.valid?
      sanitized_params = params_sanitizer.cleaned
      employees = FetchActiveEmployees.call(sanitized_params)
      formatted_response = response_formatter.from_collection(employees)

      render json: formatted_response, status: 200
    else
      render json: { message: "Incorrect parameters" }, status: 400
    end
  end

  private
  def response_formatter
    ResponseFormatter.new(request.original_url)
  end

  def permited_params
    params.permit(:dept_no, :page, :per_page)
  end

  def params_sanitizer
    DepartmentParamsSanitizer.new(permited_params.to_h)
  end
end
