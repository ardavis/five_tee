function updateTask(params, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/update`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState({tasks: data.tasks, selected_task: data.selected_task});
    }
  });
}

function getSelectedTask(id, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/select`,
    data: {task: {id: id}},
    dataType: 'json',
    success: function(data){
      index.setState({selected_task: data});
      $('.show.task.modal').modal('toggle');
    }
  });
}


function timerOn(target, start_time){
  target.timer({
    seconds: start_time,
    format: '%h hr %m min %s sec'
  });
}

function timerOff(target){
  target.timer('remove');
}


function taskButtonAction(action, id, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/${action}`,
    data: {task: {id: id}},
    dataType: 'json',
    success: function(data){
      index.setState(data);
    }
  });
}