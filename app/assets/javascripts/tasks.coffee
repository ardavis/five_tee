ready = ->
  $('#new_task_btn').click ->
    # May need to re-render the form due to potential instance
    # variable issues.
    # $("#new-modal-body").html("<%=j render 'form' %>");
    $('#newModal').modal('toggle')


  $('#newModal').on 'shown.bs.modal', ->
    $('#task_title').focus()


$(document).ready(ready)
$(document).on('page:load', ready)