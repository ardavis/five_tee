function newTask(params, klass, new_task_form){
  $.ajax({
    type: 'PATCH',
    url: '/tasks/new',
    data: params,
    dataType: 'json',
    success: function(data){
      klass.setState({
        tasks: data.tasks,
        tags: data.tags,
        flash: null
      });
      new_task_form.setState({request_sent: false});
      
    },
    error: function(){
      new_task_form.setState({flash: `'${params['task']['title']}' task already exists.`});
    }
  });
}

function updateTask(params, klass){
  $.ajax({
    type: "PATCH",
    url: `/tasks/update`,
    data: params,
    dataType: 'json',
    success: function(data){
      klass.setState(
        {
          tasks: data.tasks,
          tags: data.tags,
          selected_task: data.selected_task,
          flash: null
        }
      );
    },
    error: function(){
      if (params['task']['title']){
        msg = `'${params['task']['title']}' task already exists`
      }
      else if (params['tag_name']){
        msg = `'${params['tag_name']}' tag already exists`
      }
      klass.setFlash(msg);
    }
  });
}

function newTag(params, klass, new_task_modal, tag_form){
  $.ajax({
    type: "PATCH",
    url: `/tags/new`,
    data: params,
    dataType: 'json',
    success: function(data){
      klass.setState({tags: data.tags});
      tag_form.setState({tag: data.tag});
      new_task_modal.setState({flash: null});
    },
    error: function(){
      new_task_modal.setState({flash: `'${params['tag']['name']}' tag already exists`});
    }
  });
}

function updateTag(params, index){
  $.ajax({
    type: "PATCH",
    url: `/tags/update`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState(data);
      index.setState({tag_modal_flash: null})
    },
    error: function(){
      index.setState({tag_modal_flash: `'${params['tag']['name']}' tag already exists`})
    }
  });
}

function deleteTag(id, index){
  $.ajax({
    type: "PATCH",
    url: `/tags/delete`,
    data: {tag: {id: id}},
    dataType: 'json',
    success: function(data){
      index.setState(data);
      if (index.state.filter_tag.id == id){
        index.setState({filter_tag: {name: 'All Tags'}})
      }
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

function thereAreNoErrors(){
  var errors = $('.alert.alert-danger');
  return errors.length == 0;
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

function updateFilterTag(params, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/filter`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState(
        {
          tasks: data,
          filter_tag: params['tag']
        });
    }
  });
}

function updateSort(params, index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/sort`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState(
        {
          tasks: data,
          sort_label: params.label
        });
    }
  });
}

function archiveTasks(index){
  $.ajax({
    type: "PATCH",
    url: `/archives/new`,
    dataType: 'json'
  });
}

function resetTasks(index){
  $.ajax({
    type: "PATCH",
    url: `/tasks/reset`,
    dataType: 'json',
    success: function(data){
      index.setState({tasks: data});
    }
  });
}

function archiveResetTasks(index){
  $.ajax({
    type: "PATCH",
    url: `/archives/reset`,
    dataType: 'json',
    success: function(data){
      index.setState({tasks: data});
    }
  });
}

function deleteArchive(params, index){
  $.ajax({
    type: "PATCH",
    url: `/archives/delete`,
    data: params,
    dataType: 'json',
    success: function(data){
      index.setState({archives: data});
    }
  });
}

function currentDuration(task){
  if (task.started_at){
    var now = Date.now() / 1000 | 0;
    var duration = task.duration + now - task.started_at;
  }
  else{
    duration = task.duration
  }
  return {
    hr: Math.floor(duration / 3600),
    min: Math.floor(duration / 60 % 60),
    sec: Math.floor(duration % 60)
  };
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

function downloadTasks(){
  $.ajax({
    type: 'GET',
    url: `/tasks/download`
  });
}

function downloadArchive(params){
  $.ajax({
    type: "GET",
    url: `/archives/download`,
    data: params,
    dataType: 'json'
  });
}


function blankSafe(arg){
  return arg ? arg : <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
}