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
    var task = this.props.task;
    var elem = $(`.timer#${task.id}`);
    timerOff(elem);
    this.props.handleTaskButtons('pause', task.id);
  },

  complete(){
    this.props.handleTaskButtons('complete', this.props.task.id);
  },

  delete(){
    var confirmation = confirm("Are you sure you want to delete this task?");
    if (confirmation){
      this.props.handleTaskButtons('delete', this.props.task.id);
    }
  },
  
  showTask(){
    var id = this.props.task.id;
    this.props.handleTaskShow(id);
    $('.show.task.modal').modal('toggle');
  },

  isStarted(){
    return this.props.task.started_at ? true : false;
  },
  
  setTimer(){
    var task = this.props.task;
    var elem = $(`.timer#${task.id}`);
    if (this.isStarted()){
      timerOff(elem);
      var now = Date.now() / 1000 | 0;
      var start_time = task.duration + now - task.started_at;
      timerOn(elem, start_time);
    }
    else{
      timerOff(elem);
      elem.html(task.duration_display);
    }
  },


  playOrPauseBtn(){
    if (this.isStarted()){
      return(
        <a href="javascript: void(0)" onClick={this.pause}  className='pause btn btn-default'>
          <span className="glyphicon glyphicon-pause"></span>
        </a>
      );
    }
    else{
      return(
        <a href="javascript: void(0)" onClick={this.start} className='start btn btn-default'>
          <span className="glyphicon glyphicon-play"></span>
        </a>
      );
    }
  },

  render(){
    var task = this.props.task;
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
            <a href="javascript: void(0)" onClick={this.complete} className="complete btn btn-success">
              <span className="glyphicon glyphicon-ok"></span>
            </a>
            <a href="javascript: void(0)" onClick={this.delete} className="delete btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
      </div>
    );
  }
});