ready = ->
#
#  # If a task is running on page load, start the timer
#  # Use the existing duration as the start time
#
#

  set_timer()


  $('#new_task_btn').click ->
    # May need to re-render the form due to potential instance
    # variable issues.
    $('#newModal').modal('toggle')

  date_picker()


  $('#save_task_btn').click (e) ->
    e.preventDefault()
    $('#new_task').submit()

  $('#newModal').on 'shown.bs.modal', ->
    $('#task_title').focus()


date_picker = ->
  $('#task_due_date').click (e) ->
    e.preventDefault()
    $(this).datepicker
      format: 'yyyy-mm-dd'
      todayHighlight: true
    $(this).datepicker('show')


set_timer = ->
  task_element = $("#task-running")
  running_time_element = task_element.find('.running_time')
  duration_field = task_element.find('input#duration_field')
  started_field = task_element.find('input#started_field')
  now = Date.now() / 1000 | 0
  start_time = +duration_field.val() + now - started_field.val()
  running_time_element.timer({
    seconds: start_time,
    format: '%m min %s sec'
  })


window.set_timer = set_timer
window.date_picker = date_picker

$(document).ready(ready)
$(document).on('page:load', ready)