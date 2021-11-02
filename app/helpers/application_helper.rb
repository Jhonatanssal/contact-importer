# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    alert_class = {
      "success" => "alert-success",
      "error" => "alert-danger",
      "notice" => "alert-info",
      "alert" => "alert-danger",
      "warn" => "alert-warning"
    }

    alert_class[type]
  end
end
