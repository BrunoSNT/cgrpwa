class MainController < ApplicationController
  def index
    @horas_cobradas = Setup.last.weekly_hours
    @activity_count = Activity.count
    @main_page = "Pessoal"
    @page_title = "Dashboard"

    @clockify_key = current_user.clockify_key
    @user_id = current_user.clockify_user_id

    if current_user.clockify_active_workspace_id
      @active_workspace = current_user.clockify_active_workspace_id
    else
      response_workspace_active = HTTP.headers('Content-Type': 'application/json', 'x-api-key': "#{@clockify_key}")
                                      .get("https://api.clockify.me/api/users/#{@user_id}/")

      @active_workspace = JSON.parse(response_workspace_active)["activeWorkspace"]
      current_user.clockify_active_workspace_id = @active_workspace
      current_user.save
    end

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

    if current_user.total_lifetime
      @response_workspace_total = current_user.total_lifetime
    else
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
      current_user.total_lifetime = @response_workspace_total
      current_user.save
    end
  end

  def att_saw_did_good
    current_user.sawdidgood = true
    current_user.save
  end

  def att_sawnotifications
    current_user.sawnotifications = true
    current_user.save
  end

  def wallet
    @main_page = "Pessoal"
    @page_title = "Carteira"

    @extracts = current_user.extracts.order(created_at: :desc).order(kind: :asc)
  end

  def reembolsos
    @main_page = "Admin"
    @page_title = "Reembolsos"
    @repays = current_user.repays
  end
end
