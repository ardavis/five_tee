class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = {tasks} = this.props;

    this.componentDidMount = this.componentDidMount.bind(this);
    this.componentDidUpdate = this.componentDidUpdate.bind(this);
    this.button_action = this.button_action.bind(this);
    this.set_buttons = this.set_buttons.bind(this);
    this.remove_buttons = this.remove_buttons.bind(this);
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
    id = elem.parent().parent().parent().data('val');
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
      console.log(task_id);

      e.data.self.button_action(task_id, "start", 'GET');
    });
    
    $(".complete_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_ids($(this));
      console.log(task_id);
      e.data.self.button_action(task_id, "complete", 'GET')
    })
  }


  remove_buttons(){
    $('.pause_btn').unbind();
    $('.play_btn').unbind();
    $('.complete_btn').unbind();
    console.log($('.complete_btn'));
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





