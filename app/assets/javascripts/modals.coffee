ready = ->

  # New modal
  $('#new_task_btn').click ->
    $('#newModal').modal('toggle')

  # Show task modal
  $('#show_task_btn').click ->
    $("#show-task-modal").html("<%=j render 'show_modal' %>");
    $('#show-task-modal').modal('toggle')



$(document).ready(ready)
$(document).on('page:load', ready)
