module ApplicationHelper
  
  def flash_class(level)
    case level
        when 'notice' then "alert-info alert-dismissable"
        when 'success' then "alert-success alert-dismissable"
        when 'error' then "alert-danger alert-dismissable"
        when 'alert' then "alert-danger alert-dismissable"
    end
  end
end
