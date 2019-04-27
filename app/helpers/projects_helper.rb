module ProjectsHelper
    
    def percentageDone(project)
        if project.start_date
            daysExpected = (project.enddate.to_date - project.start_date.to_date)   # quantidade de dias que o projeto deve durar
            daysTranspired = (Date.today - project.start_date.to_date).to_i # quantidade de dias que passaram do inicio do projeto ate agora
        else
            daysExpected = (project.enddate.to_date - project.created_at.to_date)   # quantidade de dias que o projeto deve durar
            daysTranspired = (Date.today - project.created_at.to_date).to_i # quantidade de dias que passaram do inicio do projeto ate agora
        end
        return ((daysTranspired / daysExpected) * 100).ceil
    end

    def project_color(project)
        percentage = percentageDone(project)
        if percentage < 50
            return "danger"
        elsif percentage < 75
            return "warning"
        else
            return "success"
        end
    end
end
