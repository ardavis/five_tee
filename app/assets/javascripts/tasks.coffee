ready = ->

  # If a task is running on page load, start the timer
  # Use the existing duration as the start time
  currently_running_task = $('.task[data-running=true]')
  running_element = currently_running_task.find('.running_time')

  running_element.timer
    seconds: running_element.data('duration')


  # Update running task timers every second
  $('.container').on 'click', '.play_btn', ->
    # Start the timer
    task_element = $(this).closest('.task')
    running_time_element = task_element.find('.running_time')
    $('.running_time').timer('pause')

    start_time = running_time_element.data('duration')
    console.log start_time
    running_time_element.timer
      seconds: start_time

    # Set all buttons to be 'play'
    $('.play_btn').removeClass('hide')
    $('.pause_btn').addClass('hide')

    # Set current button to be a pause
    task_element.find('.pause_btn').removeClass('hide')
    task_element.find('.play_btn').addClass('hide')

  $('.container').on 'click', '.pause_btn', ->
    # Stop the timer
    task_element = $(this).closest('.task')
    running_time_element = task_element.find('.running_time')
    running_time_element.timer('pause')

    # Set current button to be a pause
    task_element.find('.pause_btn').addClass('hide')
    task_element.find('.play_btn').removeClass('hide')

  $('#new_task_btn').click ->
    # May need to re-render the form due to potential instance
    # variable issues.
    # $("#new-modal-body").html("<%=j render 'form' %>");
    $('#newModal').modal('toggle')

  $('#task_due_date').click (e) ->
    e.preventDefault()
    $(this).datepicker
      format: 'yyyy-mm-dd'
      todayHighlight: true

    $(this).datepicker('show')

  $('#save_task_btn').click (e) ->
    e.preventDefault()
    $('#new_task').submit()

  $('#newModal').on 'shown.bs.modal', ->
    $('#task_title').focus()



  hide = (element) ->
    element.addClass('hide')

  show = (element) ->
    task = element.closest('.task')
    btn =
    element.removeClass('hide')

$(document).ready(ready)
$(document).on('page:load', ready)