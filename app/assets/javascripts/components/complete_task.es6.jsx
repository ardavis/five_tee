class CompleteTask extends React.Component {

  constructor(props){
    super(props);
  }


  duration_display(task){
    if (task.duration)
      return (<p id="duration_display">{task.duration_display}</p>);
    else
      return (<p>Not Started</p>);
  }

  play_pause_btn(task){
    if (task.started_at) {
      return (
        <a href={'tasks/' + task.id + '/pause'} className="pause_btn btn btn-default" data-remote="true" format="js">
          <span className="glyphicon glyphicon-pause"></span>
        </a>
      );
    }
    else {
      return (
        <a href={'tasks/' + task.id + '/start'} className="play_btn btn btn-default">
          <span className="glyphicon glyphicon-play"></span>
        </a>
      );
    }
  }

  render () {
    task = this.props.task;
    duration = task.duration ? task.duration : 0;
    running = task.started_at ? true : false;
    row_id = (`task-${running ? 'running' : 'paused'}`);
    show_link = `/show_task_modal?id=${task.id}`;
    duration_class = `col-md-4 ${running ? 'running_time' : ''}`;


    return(
      <div className="row well" value={task.id}>
        <div className="col-md-4">
          <h4>
            <a className="show_link" id={task.title} href='#' value={task.id}>
              {task.title}
            </a>
          </h4>
        </div>
        <div className="col-md-4">
          {"Time took: "}
          {task.duration_display}
        </div>
        <div className="col-md-4">
          {"Finished "}
          {task.finished_display}
          <div className="pull-right">
            <a href="#" className="restart_btn btn btn-default">
              <span className="glyphicon glyphicon-arrow-up"></span>
            </a>
          </div>
        </div>
      </div>

    )

  }
}