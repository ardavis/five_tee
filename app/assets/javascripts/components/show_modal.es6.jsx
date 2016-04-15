class ShowModal extends React.Component{
  constructor(props){
    super(props);
    this.state = {task} = this.props;
  }

  update_modal(id){
    self = this;
    $.ajax({
      type: "GET",
      url: `/tasks/${id}/show`,
      dataType: 'json',
      success: function(data){
        self.setState({task: data});
        $('.showModal').modal('toggle');
      }
    });
  }

  fetch_id(elem){
    id = elem.attr('value');
    return id;
  }

  set_link(){
    $(".show_link").click({self: this}, function(e){
      task_id = e.data.self.fetch_id($(this));
      e.data.self.update_modal(id);
    });

  }

  remove_link(){
    $(".show_link").off('click');
  }

  set_timer() {
    task = this.state.task;
    if ($('.task-running').length > 0) {
      elem = $(".show-task-running");
      task_timer(elem, task.duration, task.started_at);
    }
  }

  duration_display(task){
    if (task.duration) {
      return (<p id="duration_display">{task.duration_display}</p>);
    }
    else
      return (<p>Not Started</p>);
  }

  timer_or_duration(){
    task = this.state.task;
    if (task){
      if ($('.task-running').length > 0){
        return(<div className="show-task-running"></div>);
      }
      else{
        return this.duration_display(task);
      }
    }
    else{
      return <p>no task?</p>
    }
  }


  componentDidMount(){
    this.set_link();
    this.set_timer();
  }

  componentDidUpdate(){
    this.remove_link();
    this.set_link();
    this.set_timer();
  }


  render(){
    task = this.state.task;

    return(
      <div className="showModal modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">×</button>
              <h4 className="modal-title">{task.title}</h4>
            </div>
            <div className="modal-body">
              <div className="row">
                <div className="col-md-8">
                  <label>Description:</label>
                  <p>
                    {task.desc}
                  </p>
                </div>
                <div className="col-xs-4">
                  <label>Tag:</label>
                  <p>{task.tag}</p>
                </div>
              </div>
              <div className="row table-bordered">
                <div className="col-xs-4">
                  <label>Due Date:</label>
                  <p>{task.due_date}</p>
                </div>
                <div className="col-xs-4">
                  <label>Created At:</label>
                  <p>{task.created_at_show}</p>
                </div>
                <div className="col-xs-4">
                  <label>Completed At:</label>
                  <p>{task.completed_at_show}</p>
                </div>
              </div>
              < div className="row">
                <div className="displays_timer col-xs-4">
                  <label className="Duration">Duration:</label>
                  {this.timer_or_duration()}
                </div>
              </div>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-primary edit_task_link">Edit</button>
              <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}