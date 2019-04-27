class GoogleAgendaController < ApplicationController
  def index
    
  end
  
  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendars_url
  end

  def calendars
    @main_page = "Pessoal"
    @page_title = "Calendário"
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    rescue Google::Apis::AuthorizationError
    response = client.refresh!

    session[:authorization] = session[:authorization].merge(response)

    retry
  end

  def events
    @main_page = "Pessoal"
    @page_title = "Calendário"
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events(params[:calendar_id])
  end

  def new_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    today = Date.today

    @start = DateTime.new(params[:start]["(1i)"].to_i, params[:start]["(2i)"].to_i, params[:start]["(3i)"].to_i, params[:start]["(4i)"].to_i, params[:start]["(5i)"].to_i)
    @end = DateTime.new(params[:end]["(1i)"].to_i, params[:end]["(2i)"].to_i, params[:end]["(3i)"].to_i, params[:end]["(4i)"].to_i, params[:end]["(5i)"].to_i)
    @summary = params[:summary]
    @color = params[:color_id]

    # adicionar mais params -> https://developers.google.com/calendar/v3/reference/events/insert
    event = Google::Apis::CalendarV3::Event.new({
      start: {date_time: @start},
      end: {date_time: @end},
      summary: @summary,
      color_id: @color
    })

    service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
  end

  private

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
