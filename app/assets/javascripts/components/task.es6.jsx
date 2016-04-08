class Task extends React.Component {

  constructor(props){
    super(props);
  }

  render () {
    task = this.props.task;
    row_id = (`task-${task.started_at ? 'running' : 'paused'}`);
    task_link = `/show_task_modal?id=${task.id}`;





    return(
      <div className="row well task" id={row_id}>
        <div className="col-md-4">
          <h4 href={task_link}>{task.title}</h4>
        </div>
      </div>

    )

  }
}