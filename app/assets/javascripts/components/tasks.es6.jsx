class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = {tasks, type} = this.props;

    this.componentDidMount = this.componentDidMount.bind(this);
    this.componentDidUpdate = this.componentDidUpdate.bind(this);
    this.toggle_task = this.toggle_task.bind(this);
    this.set_buttons = this.set_buttons.bind(this);
    this.remove_buttons = this.remove_buttons.bind(this);
  }

  toggle_task(id, state){
    self = this;
    $.ajax({
      type: "GET",
      url: `/tasks/${id}/${state}`,
      dataType: 'json',
      success: function(data){
        self.setState({tasks: data});
      }
    });
  }
  
  
  set_buttons(){
    $('.pause_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = $(this).data('val');
      e.data.self.toggle_task(task_id, 'pause');
    });


    $('.play_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = $(this).data('val');
      e.data.self.toggle_task(task_id, "start");
    });
  }


  remove_buttons(){
    $('.pause_btn').unbind();
    $('.play_btn').unbind();
  }




  componentDidMount(){
    this.set_buttons();
    set_all_timers();

  }
  
  componentDidUpdate(){
    this.remove_buttons();
    this.set_buttons();
    set_all_timers();
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



    console.log(tasks.incomplete);
    tasks.incomplete.forEach(function (task){
      task_row = <IncompleteTask task={task}></IncompleteTask>;
      task_rows.incomplete.push(task_row);
    });

    tasks.complete.forEach(function (task){
      task_row = <CompleteTask task={task}></CompleteTask>;
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





