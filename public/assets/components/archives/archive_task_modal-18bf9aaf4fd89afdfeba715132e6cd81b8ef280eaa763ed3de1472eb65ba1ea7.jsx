var ArchiveTaskModal = React.createClass({

  componentDidMount(){
    var unselectTask = this.props.unselectTask;
    $('.show.task.modal').on('hidden.bs.modal', function (e) {
      unselectTask();
    });
  },

  render(){
    var task = this.props.task;

    return(
      <div className="show task modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h3>{task.title}</h3>
            </div>
            <div className="modal-body">
              <div className="row">
                <div className="col-md-8">
                  <label>Description:</label>
                  <p>{task.desc}</p>
                </div>
                <div className="col-xs-4">
                  <label>Tag:</label>
                  <p>{task.tag.name}</p>
                </div>
              </div>
              <div className="row table-bordered">
                <br/>
                <div className="col-xs-4">
                  <label>Due Date:</label>
                  <p>{task.due_date}</p>
                </div>
                <div className="col-xs-4">
                  <label>Created At:</label>
                  <div>{task.created_at}</div>
                </div>
                <div className="col-xs-4">
                  <label>Completed At:</label>
                  <div>{task.completed_at_display}</div>
                </div>
              </div>
              <br/>
              <div className="row">
                <div className="col-md-8">
                  <label>Duration:</label>
                  <div>
                    <p>{task.duration_display}</p>
                  </div>
                </div>
              </div>
            </div>
            <div className="modal-footer">
              <span><a className="btn btn-default" href="javascript: void(0)" data-dismiss="modal">Close</a></span>
            </div>
          </div>
        </div>
      </div>
    );
  }

});