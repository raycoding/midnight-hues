module ApplicationHelper
	def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "notice"
        "alert-info"
      else
        "alert-warning"
    end
  end
end
