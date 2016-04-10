class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = {tasks} = this.props;
  }

  button_action(id, state, type){
    self = this;
    $.ajax({
      type: type,
      url: `/tasks/${id}/${state}`,
      dataType: 'json',
      success: function(data){
        self.setState({tasks: data});
      }
    });
  }

  fetch_ids(elem){
    id = elem.parent().parent().parent().attr('value');
    return id;
  }

  set_buttons(){

    $('.pause_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_ids($(this));
      e.data.self.button_action(task_id, 'pause', 'GET');
    });


    $('.play_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_ids($(this));

      e.data.self.button_action(task_id, "start", 'GET');
    });
    
    $(".complete_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_ids($(this));
      e.data.self.button_action(task_id, "complete", 'GET')
    });

    $(".restart_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_ids($(this));
      e.data.self.button_action(task_id, "restart", 'GET')
    });

    $(".delete_btn").click({self: this}, function(e){
      e.preventDefault();
      sure = confirm("Are you sure you want to delete this task?");
      if (sure){
        task_id = e.data.self.fetch_ids($(this));
        e.data.self.button_action(task_id, "destroy", 'GET')
      }
    });


  }


  remove_buttons(){
    $('.pause_btn').off('click');
    $('.play_btn').off('click');
    $('.complete_btn').off('click');
    $('.delete_btn').off('click');
    $('.restart_btn').off('click');
  }


  componentDidMount(){
    this.set_buttons();
  }
  
  componentDidUpdate(){
    this.remove_buttons();
    this.set_buttons();
  }


  tasks_or_placeholder(task_rows){
    if (task_rows.incomplete.length == 0){
      task_rows.incomplete = <div className="container"><h4>You have no incomplete tasks</h4></div>
    }
    if (task_rows.complete.length == 0){
      task_rows.complete = <div className="container"><h4>You have no complete tasks</h4></div>
    }
  }


  render() {
    tasks = this.state.tasks;
    task_rows = {incomplete: [], complete: []};
    
    tasks.incomplete.forEach(function (task){
      task_row = <IncompleteTask task={task} key={task.id}></IncompleteTask>;
      task_rows.incomplete.push(task_row);
    });

    tasks.complete.forEach(function (task){
      task_row = <CompleteTask task={task} key={task.id}></CompleteTask>;
      task_rows.complete.push(task_row);
    });

    this.tasks_or_placeholder(task_rows);

    return(
      <div className="incomplete_tasks">
        <h1>Tasks</h1>
        {task_rows.incomplete}
        <h1>Completed Tasks</h1>
        {task_rows.complete}
      </div>
    );
  }
}





