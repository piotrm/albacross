class Api::V1::EmployeesController < ApplicationController
  def index
    if params_sanitizer.valid?
      sanitized_params = params_sanitizer.cleaned
      employees = FetchEmployees.call(sanitized_params)
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
    params.permit(:page, :per_page, :salary_from, :salary_to)
  end

  def params_sanitizer
    EmployeeParamsSanitizer.new(permited_params.to_h)
  end
end
