class HoursController < ApplicationController
  include ApplicationHelper

  def index
    @page_title = "Horas"
    @main_page = "Pessoal"
    @clockify_key = current_user.clockify_key
    @user_id = current_user.clockify_user_id

    @projects = Project.current_projects
  end

  def create
    @clockify_key = params[:clockify_key]

    require "http"
    require "json"

    current_user.clockify_key = @clockify_key

    # response = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
    #                  .get("https://api.clockify.me/api/workspaces/#{current_user.clockify_active_workspace_id}/timeEntries/user/#{current_user.clockify_user_id}")
    if !@clockify_key.nil?
      if !@clockify_user_id.nil?
      else
        response_2 = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                         .get("https://api.clockify.me/api/workspaces/")

        # @user_data = JSON.parse(response)
        @user_data_2 = JSON.parse(response_2)
        @user_id = nil

        @user_data_2.each do |workspace|
          id = workspace["id"]
          response_workspace = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                   .post("https://api.clockify.me/api/workspaces/#{id}/reports/summary/", json:
                                       {
                                           startDate: "2017-02-18T00:00:00.000Z",
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
          response_workspace_json = JSON.parse(response_workspace)
          if !response_workspace_json["timeEntries"].nil?
            @user_id = response_workspace_json["timeEntries"][0]["user"]["id"]
          end
          if !@user_id.nil?
            current_user.clockify_user_id = @user_id
            current_user.save
            break
          end
        end
      end
    end

    if current_user.save
      flash[:success] = "Conectado ao clockify"
      redirect_to hours_path
    else
      flash[:danger] = "Erro ao conectar ao clockify"
      redirect_to hours_path
    end
  end

  def hours_dashboard
    @horas_cobradas = Setup.last.weekly_hours
    @page_title = "Horas"
    @main_page = "Admin"
    @time = (Time.now - 1.day)
    while !@time.monday?
      @time -= 1.day
    end

    @array_users = []

    User.all.each do |user|
      @clockify_key = user.clockify_key
      @user_id = user.clockify_user_id

      if current_user.clockify_active_workspace_id
        @active_workspace = user.clockify_active_workspace_id
      else
        response_workspace_active = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                        .get("https://api.clockify.me/api/users/#{@user_id}/")

        @active_workspace = JSON.parse(response_workspace_active)["activeWorkspace"]
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

      total_hours = clockify_friendly_hour_just_hour(JSON.parse(@response_workspace)["totalTime"])
      var_user = {user: user, hours: total_hours, hours_percentage: (hour_percentage(total_hours, @horas_cobradas)).to_i, color: hour_color(total_hours, @horas_cobradas)}
      @array_users << var_user
    end

    @array_users.sort_by!{ |obj| obj[:hours_percentage] }.reverse!
  end
end
