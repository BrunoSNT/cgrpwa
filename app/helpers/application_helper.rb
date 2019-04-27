module ApplicationHelper

  def clockify_friendly_hour(clockify_hour)
    unless clockify_hour.nil?
      matches = clockify_hour.match(/PT(.*)H(.*)M(.*)S/)
      unless matches
        matches = clockify_hour.match(/PT(.*)H(.*)M/)
        unless matches
          matches = clockify_hour.match(/PT(.*)H/)
        end
      end
      if matches
        hour_string = "#{matches[1]}h#{matches[2]}m"
      else
        hour_string = "< 1h"
      end
    else
      hour_string = "-"
    end

    hour_string
  end

  def clockify_friendly_hour_just_hour(clockify_hour)
    unless clockify_hour.nil?
      matches = clockify_hour.match(/PT(.*)H(.*)M(.*)S/)
      unless matches
        matches = clockify_hour.match(/PT(.*)H(.*)M/)
        unless matches
          matches = clockify_hour.match(/PT(.*)H/)
        end
      end
      if matches
        hour_string = "#{matches[1]}h"
      else
        hour_string = "-"
      end
    else
      hour_string = "-"
    end

    hour_string
  end

  def clockify_parsed_hours(clockify_hour)
    unless clockify_hour.nil?
      matches = clockify_hour.match(/PT(.*)H(.*)M(.*)S/)
      unless matches
        matches = clockify_hour.match(/PT(.*)H(.*)M/)
        unless matches
          matches = clockify_hour.match(/PT(.*)H/)
        end
      end
    else
      matches = []
    end

    matches
  end

  def hour_color(hours, total_hours)
    hour_division = (hours.to_f)/total_hours

    if hour_division < 0.5
      color = "#FF3012"
    elsif hour_division < 1.0
      color = "#f7d036"
    else
      color = "#48db85"
    end

    color
  end

  def hour_percentage(hours, total_hours)
    hour_division = (hours.to_f)/total_hours

    hour_division*100
  end

  def notification_color(kind)
    case kind
    when "cash"
      return "success"
    when "bell"
      return "warning"
    when "ticket"
      return "primary"
    else
      return "danger"
    end
  end

  def payments_by_status(status)
    Payment.where(status: status)
  end

  def repays_by_status(status)
    Repay.where(status: status)
  end

  def repay_status_color(repay)
    case repay.status
    when "pendente"
      "warning"
    when "negado"
      "danger"
    when "pagamento_aprovado"
      "success"
    when "pago"
      "success"
    when "recibo_feito"
      "primary"
    end
  end

  def extract_kind(extract)
    if extract.credit?
      return "success"
    end

    "danger"
  end

  def deal_color(deal)
    diff_date = (deal.deal_date - 0.days.ago).to_i / 3600 / 24
    if diff_date < 0
      "#d9d9db"
    elsif diff_date < 1
      "#ff8989"
    elsif diff_date < 3
      "#f8ff96"
    elsif diff_date < 5
      "#9fff7a"
    else
      "#bcffd9"
    end
  end
end
