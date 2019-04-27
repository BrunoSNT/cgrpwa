class DealDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Deal.id" },
      client_name: { source: "Deal.client_name"},
      telephone1: { source: "Deal.telephone1" },
      deal_date: { source: "Deal.deal_date" },
      arrival: { source: "Deal.arrival" },
      sector: { source: "Deal.sector" }
    }
  end

  def data
    records.map do |record|
      {
        id: record.id,
        client_name: record.client_name,
        telephone1: record.telephone1,
        deal_date: record.deal_date,
        arrival: record.arrival,
        sector: record.sector
      }
    end
  end

  def get_raw_records
    # insert query here
    Deal.all
  end

end
