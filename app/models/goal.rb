class Goal < ApplicationRecord

  def achieved_goal
    if self.name == "Projetos"
      Project.this_year_projects.count
    elsif self.name == "Faturamento"
      Project.faturamento
    elsif self.name == "NPS"
      Project.total_nps
    else
      10
    end
  end
end