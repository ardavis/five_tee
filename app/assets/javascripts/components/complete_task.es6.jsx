var CompleteTask = React.createClass({
  
  restart(){
    this.props.handleTaskButtons('restart', this.props.task.id);

  },
  
  render (){
    task = this.props.task;
    return (
      <div className="row well task">
        <div className="col-md-4">
          <h4>
            <a className="show_link" href="#">
              {task.title}
            </a>
          </h4>
        </div>
        <div className="col-md-4">
          <div>
            Time took: {task.duration_display}
          </div>
        </div>
        <div className="col-md-4">
          <div className="pull-right">
            <a href="javascript: void(0)" onClick={this.restart} className="btn btn-default">
              <span className="glyphicon glyphicon-arrow-up"></span>
            </a>
          </div>
        </div>
      </div>
    );
  }

});