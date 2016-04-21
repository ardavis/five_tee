var IncompleteTask = React.createClass({


  componentDidMount(){
    this.setTimer();
  },

  componentDidUpdate(){
    this.setTimer();
  },

  start(){
    this.props.handleTaskButtons('start', this.props.task.id);
  },

  pause(){
    elem = $(`.timer#${task.id}`);
    timerOff(elem);
    this.props.handleTaskButtons('pause', this.props.task.id);
  },

  complete(){
    this.props.handleTaskButtons('complete', this.props.task.id);
  },

  delete(){
    confirmation = confirm("Are you sure you want to delete this task?");
    if (confirmation){
      this.props.handleTaskButtons('delete', this.props.task.id);
    }
  },
  
  showTask(){
    id = this.props.task.id;
    this.props.handleTaskShow(id);
    $('.show.task.modal').modal('toggle');
  },

  isStarted(){
    return this.props.task.started_at ? true : false;
  },
  
  setTimer(){
    if (this.isStarted()){
      task = this.props.task;
      now = Date.now() / 1000 | 0;
      start_time = task.duration + now - task.started_at;
      elem = $(`.timer#${task.id}`);
      timerOn(elem, start_time);
    }
  },


  playOrPauseBtn(){
    if (this.isStarted()){
      return(
        <a href="javascript: void(0)" onClick={this.pause}  className='btn btn-default'>
          <span className="glyphicon glyphicon-pause"></span>
        </a>
      );
    }
    else{
      return(
        <a href="javascript: void(0)" onClick={this.start} className='btn btn-default'>
          <span className="glyphicon glyphicon-play"></span>
        </a>
      );
    }
  },

  render(){
    task = this.props.task;
    return (
      <div className="row well task">
        <div className="col-md-4">
          <h4>
            <a onClick={this.showTask} className="show_link" href="javascript: void(0)">
              {task.title}
            </a>
          </h4>
        </div>
        <div className="col-md-4">
          <div className="timer" id={task.id}>
            {task.duration_display}
          </div>
        </div>
        <div className="col-md-4">
          <div className="pull-right">
            {this.playOrPauseBtn()}
            <a href="javascript: void(0)" onClick={this.complete} className="btn btn-success">
              <span className="glyphicon glyphicon-ok"></span>
            </a>
            <a href="javascript: void(0)" onClick={this.delete} className="btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
      </div>
    );
  }
});