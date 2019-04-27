namespace :scheduler do
    desc "This task is called by the Heroku scheduler add-on"
    task :update_user_coins => :environment do
      require 'net/http'
      require 'uri'
      require 'json'
      if DateTime.now.sunday?
        puts "Atualizando os dinheiros da galera"
        User.all.each do |user|

          @clockify_key = user.clockify_key
          @user_id = user.clockify_user_id

          response_workspace_active = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                          .get("https://api.clockify.me/api/users/#{@user_id}/")

          @active_workspace = JSON.parse(response_workspace_active)["activeWorkspace"]

          @time = (Time.now - 1.day)
          while !@time.monday?
            @time -= 1.day
          end

          @response_workspace = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                    .post("https://api.clockify.me/api/workspaces/#{@active_workspace}/reports/summary/", json:
                                        {
                                            startDate: @time.strftime("%Y-%m-%dT00:00:00.000Z"),
                                            endDate: Time.now.strftime("%Y-%m-%dT00:00:01.999Z"),
                                            me: "true",
                                            userGroupIds: [],
                                            userIds: [],
                                            projectIds: [],
                                            clientIds: [],
                                            taskIds: [],
                                            tagIds: [],
                                            billable: "BOTH",
                                            includeTimeEntries: "true",
                                            zoomLevel: "week",
                                            description: "",
                                            archived: "All",
                                            roundingOn: "false"
                                        }
                                    )


          if clockify_parsed_hours(JSON.parse(@response_workspace)["totalTime"]).is_a? Integer
            user.coins += clockify_parsed_hours(JSON.parse(@response_workspace)["totalTime"])
            user.save
            puts "#{user.full_name} => #{user.coins}"
            user.notifications.create(title: "Saldo de Focoins Atualizado", message: "Você realizou #{clockify_friendly_hour(JSON.parse(@response_workspace)['totalTime'])} e ganhou #{clockify_parsed_hours(JSON.parse(@response_workspace)['totalTime'])} focoins essa semana", kind: "cash")
          end

        end
      else
        puts "Nao é domingo"
      end
    end

    desc "This task is called by the Heroku scheduler add-on"
    task :update_user_hours => :environment do
      require 'net/http'
      require 'uri'
      require 'json'

      puts "Atualizando as hora da galera"
      User.all.each do |user|
        @clockify_key = user.clockify_key
        @user_id = user.clockify_user_id
        @time = (Time.now - 1.day)

        response_workspace_active = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                        .get("https://api.clockify.me/api/users/#{@user_id}/")

        @active_workspace = JSON.parse(response_workspace_active)["activeWorkspace"]
        @response_workspace_total = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                        .post("https://api.clockify.me/api/workspaces/#{@active_workspace}/reports/summary/", json:
                                            {
                                                startDate: @time.strftime("2017-01-01T00:00:00.000Z"),
                                                endDate: Time.now.strftime("%Y-%m-%dT00:00:01.999Z"),
                                                me: "true",
                                                userGroupIds: [],
                                                userIds: [],
                                                projectIds: [],
                                                clientIds: [],
                                                taskIds: [],
                                                tagIds: [],
                                                billable: "BOTH",
                                                includeTimeEntries: "true",
                                                zoomLevel: "week",
                                                description: "",
                                                archived: "All",
                                                roundingOn: "false"
                                            }
                                        )

        user.total_lifetime = @response_workspace_total
        user.save
      end
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
      if matches
        minutos =  matches[2].to_i + 60 * matches[1].to_i
      else
        minutos = 10
      end
      minutos
    end

    def clockify_friendly_hour(clockify_hour)
      unless clockify_hour.nil?
        matches = clockify_hour.match(/PT(.*)H(.*)M(.*)S/)
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

end