function updateIndex(component){
  $.ajax({
    type: "GET",
    url: `/tasks/fetch_all`,
    dataType: 'json',
    success: function(data){
      component.setState(data);
    }
  });
}

function formattedDuration(duration){
  if (duration){
    hours = Math.floor(duration / 3600);
    mins = Math.floor(duration / 60 % 60);
    secs = duration % 60;
    return `${hours} hours ${mins} mins ${secs} secs`;
  }
  else{
    return 'Not started';
  }
}

function timerOn(target, start_time){
  console.log(start_time);
  target.timer({
    seconds: start_time,
    format: '%h hr %m min %s sec'
  });
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