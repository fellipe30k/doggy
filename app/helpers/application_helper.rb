module ApplicationHelper
  def filter_by_company(scope)
    current_user.staff? ? scope : scope.by_company(@current_company_id)
  end
end
