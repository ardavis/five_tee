Then(/^the timer should be working$/) do
  timer = find('.running_time')
  @time = timer.native.text
  sleep 1
  expect(@time).to_not eq(timer.native.text)
end

Then(/^the timer should be paused$/) do
  timer = find('#duration_display')
  @time = timer.native.text
  sleep 1
  expect(@time).to eq(timer.native.text)
end