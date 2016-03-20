Array::real_strings = ->
  (elem for elem in this when elem != '' and elem != "\n")

ready = ->
#
#  # If a task is running on page load, start the timer
#  # Use the existing duration as the start time
#
#
  set_timer('task', 'string')


  date_picker()


  $('#save_task_btn').click (e) ->
    e.preventDefault()
    $('#new_task').submit()

  $('#newModal').on 'shown.bs.modal', ->
    $('#task_title').focus()


date_picker = ->
  $('.due_date').click (e) ->
    e.preventDefault()
    $(this).datepicker({
      format: 'mm-dd-yyyy'
      todayHighlight: true
    })
    $(this).datepicker('show')

    $('.due_date').on 'change', ->
      $('.datepicker').hide()


fix_date_input = ->
  date_elem = $('.due_date')
  unless date_elem.val() == ''
    broken_date = date_elem.val()
    fixed_date = broken_date[5..9]
    fixed_date += '-'
    fixed_date += broken_date[0..3]
    date_elem.val(fixed_date)


set_timer = (duration_source, target) ->
  task_running = $('input#task_running').val() == 'true'
  if duration_source == 'task'
    task_element = $("#task-running")
    running_time_element = task_element.find('.running_time')
    duration_field = task_element.find('input#duration_field')
    started_field = task_element.find('input#started_field')
    now = Date.now() / 1000 | 0
    start_time = +duration_field.val() + now - started_field.val()
    target = running_time_element
    task_running = true
  else
    duration_array = duration_source.html().split(' ')
    start_time = +duration_array[0] * 3600
    start_time += +duration_array[2] * 60
    start_time += +duration_array[4]
  if task_running
    target.timer({
      seconds: start_time,
      format: '%h hr %m min %s sec'
    })

set_all_timers = () ->
  set_timer('task', 'string')
  set_timer($('.running_time'), $('.displays_timer'))
  set_timer($('.displays_timer'), $('.edit_timer'))



set_hidden_field = ->
  duration = $("input[name='hours_input']").val() * 3600
  duration += $("input[name='mins_input']").val() % 60 * 60
  duration += $("input[name='secs_input']").val() % 60
  $('#duration_submit').val(duration)


set_duration_field = ->
  duration = $("input[name='hours_input']").val() * 3600
  duration += $("input[name='mins_input']").val() * 60
  duration += $("input[name='secs_input']").val()
  $('#duration_submit').val(duration)

set_duration_spinners = ->
  task_running = $('input#task_running').val() == 'true'
  current_duration = $('.edit_timer').html().split(' ').real_strings()
  hours = +current_duration[0]
  min = +current_duration[2]
  sec = +current_duration[4]

  $("input[name='hours_input']").TouchSpin({
    verticalbuttons: true,
    prefix: "hours: ",
    max: 99,
    min: 0,
    initval: hours
  })


  $("input[name='mins_input']").TouchSpin({
    verticalbuttons: true,
    prefix: "Minutes: ",
    max: 59,
    min: 0,
    initval: min
  })
  $("input[name='secs_input']").TouchSpin({
    verticalbuttons: true,
    prefix: "Seconds: ",
    max: 59,
    min: 0,
    initval: sec
  })

  $('.duration_input').on('input', set_hidden_field)
  $('.bootstrap-touchspin-up, .bootstrap-touchspin-down').click (set_hidden_field)

store_form_state = () ->
  title = $('#task_title').val()
  due_date = $('.due_date').val()
  desc = $('#task_desc').val()
  tag = $('#task_tag_id').val()
  return {'title': title, 'due_date': due_date, 'desc': desc, 'tag': tag}

set_form_state = (state) ->
  $('#task_title').val(state['title'])
  $('.due_date').val(state['due_date'])
  $('#task_desc').val(state['desc'])
  $('#task_tag_id').val(state['tag'])

set_focus = (target) ->
  setTimeout (->
    target.focus()
  ), 160

window.set_focus = set_focus
window.fix_date_input = fix_date_input
window.set_timer = set_timer
window.set_all_timers = set_all_timers
window.date_picker = date_picker
window.set_duration_field = set_duration_field
window.set_hidden_field = set_hidden_field
window.set_duration_spinners = set_duration_spinners
window.store_form_state = store_form_state
window.set_form_state = set_form_state


$(document).ready(ready)
$(document).on('page:load', ready)
