var ShowTaskModal = React.createClass({

  componentDidMount(){
    unselectTask = this.props.unselectTask;
    $('.show.task.modal').on('hidden.bs.modal', function (e) {
      unselectTask();
    });
  },

  render(){

    task = this.props.task;

    return(
      <div className="show task modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" >&times;</button>
              <h4 className="modal-title">{task.title}</h4>
            </div>
            <div className="modal-body">
              <div className="row">
                <div className="col-md-8">
                  <label>Description:</label>
                  <div>{task.desc}</div>
                </div>
                <div className="col-xs-4">
                  <label>Tag:</label>
                  <div>{task.tag ? task.tag.name : ""}</div>
                </div>
              </div>
              <div className="row table-bordered">
                <div className="col-xs-4">
                  <label>Due Date:</label>
                  <div>{task.due_date}</div>
                </div>
                <div className="col-xs-4">
                  <label>Created At:</label>
                  <div>{task.created_at}</div>
                </div>
                <div className="col-xs-4">
                  <label>Completed At:</label>
                  <div>{task.completed_at}</div>
                </div>
              </div>
              <div className="row">
                <label>Duration:</label>
                <div className="timer" id={task.id}>
                  {task.duration_display}
                </div>
              </div>
            </div>
            <div className="modal-footer">
              <span><a className="btn btn-primary" href="javascript: void(0)">Edit</a></span>
              <span><a className="btn btn-default" href="javascript: void(0)" data-dismiss="modal">Close</a></span>

            </div>
          </div>
        </div>
      </div>
    );
  }

});