// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets2/javascripts, or any plugin's
// vendor/assets2/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require datatables
//= require popper
//= require bootstrap-sprockets
//= require cocoon
//= require moment
//= require fullcalendar
//= require selectize
//= require_tree .


jQuery(document).on('turbolinks:load', function () {
  $('#deals-datatable').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#deals-datatable').data('source'),
    "pagingType": "full_numbers",
    "columns": [{
        "data": "id"
      },
      {
        "data": "client_name"
      },
      {
        "data": "telephone1"
      },
      {
        "data": "deal_date"
      },
      {
        "data": "arrival"
      },
      {
        "data": "sector"
      }
    ]
  });
});//= require serviceworker-companion
