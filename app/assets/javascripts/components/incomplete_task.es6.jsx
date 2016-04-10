class IncompleteTask extends React.Component {

  constructor(props){
    super(props);
    this.state = {task} = this.props;
    this.componentDidUpdate = this.componentDidUpdate.bind(this);
  }

  duration_display(task){
    if (task.duration) {
      return (<p id="duration_display">{task.duration_display}</p>);
    }
    else
      return (<p>Not Started</p>);
  }

  timer_or_duration(task){
    if (task.running){
      return(<div className="task-running"></div>);
    }
    else{
      return this.duration_display(task);
    }
  }

  play_pause_btn(task){
    if (task.started_at) {
      return (
        <a href="#" className="pause_btn btn btn-default" data-val={task.id}>
          <span className="glyphicon glyphicon-pause"></span>
        </a>
      );
    }
    else {
      return (
        <a href="#" className="play_btn btn btn-default" data-val={task.id}>
          <span className="glyphicon glyphicon-play"></span>
        </a>
      );
    }
  }

  complete_btn(task){
    return(
      <a href="#" className="complete_btn btn btn-success" data-val={task.id}>
        <span className="glyphicon glyphicon-ok"></span>
      </a>
    )
  }

  set_timer() {
    this.state = {task} = this.props;
    task = this.state.task;
    if (task.running) {
      elem = $(".task-running");
      task_timer(elem, task.duration, task.started_at);
    }
  }


  componentDidMount(){
    this.set_timer();
  }

  componentDidUpdate(){
    this.set_timer();
  }

  render () {
    task = this.props.task;
    duration = task.duration ? task.duration : 0;
    running = task.started_at ? true : false;
    row_id = (`task-${running ? 'running' : 'paused'}`);
    show_link = `/show_task_modal?id=${task.id}`;
    duration_class = `col-md-4 ${running ? 'running_time' : ''}`;


    return(
      <div className="row well task" id={row_id} data-val={task.id}>
        <div className="col-md-4">
          <h4>
            <a id={task.title} href={show_link} data-remote="true" format="js">
              {task.title}
            </a>
          </h4>
        </div>
        <div className="col-md-4">
          <div className={running ? "running_time" : ""}>
          {this.timer_or_duration(task)}
        </div>
        </div>
        <div className="col-md-4">
          <div className="pull-right">
            {this.play_pause_btn(task)}
            {this.complete_btn(task)}
            <a href={'tasks/' + task.id + '/destroy'} className="delete_btn btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
      </div>

    )

  }
}