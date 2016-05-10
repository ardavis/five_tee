var ArchiveTask = React.createClass({

  durationDisplay(){
    if (this.props.task.duration){
      return `Time took: ${this.props.task.duration_display}`
    }
    else{
      return 'Not Started'
    }
  },

  completedDisplay(){
    if (this.props.task.completed_at){
      return(
        <p>{`Completed: ${this.props.task.finished_display}`}</p>
      );
    }
  },
  
  selectTask(){
    this.props.handleSelectTask(this.props.task.id);
  },

  render(){
    return(
      <div className="row well small-well no-pad-marg">
        <div className="col-md-5 top-space">
          <h4><a onClick={this.selectTask} href="javascript: void(0)">{this.props.task.title}</a></h4>
        </div>
        <div className="col-md-4 top-space">
          <p>{this.durationDisplay()}</p>
        </div>
        <div className="col-md-3 top-space">
          {this.completedDisplay()}
        </div>
      </div>
    );
  }

});