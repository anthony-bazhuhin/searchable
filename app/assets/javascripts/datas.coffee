class @Builder

  @get_table: (el) ->
    cells = '';
    $.each el, (key, val) ->
      cells += "<tr scope='row'><th>"+(key+1)+"</th><td>"+val['Name']+"</td><td>"+val['Type']+"</td><td>"+
          val['Designed by']+"</td><td>"+val['weight']+"</td></tr>"
    return cells

$ ->
  $("#search_form").on("ajax:success", (e, data, status, xhr) ->
    if data.length > 0
      $("#table_cells").html Builder.get_table(data)
      $("#results").show()
      $("#no_results").hide()
    else
      $("#results").hide()
      $("#no_results").show()
  )

  $("#phrase").on 'keyup', (e) ->
    $("#search_form").submit()
