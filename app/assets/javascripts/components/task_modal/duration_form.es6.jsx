var DurationForm = React.createClass({

  componentDidMount(){
    duration = currentDuration(this.props.task);
    $('.form.duration.hr').val(duration.hr);
    $('.form.duration.min').val(duration.min);
    $('.form.duration.sec').val(duration.sec);
  },

  saveDuration(){
    var hours = +this.refs.hours.value * 3600;
    var minutes = +this.refs.minutes.value * 60;
    var seconds = +this.refs.seconds.value;
    var duration = hours + minutes + seconds;
    var params = {task: {id: this.props.task.id, duration: duration}};
    this.props.handleUpdateTask(params);
    this.props.toggleDuration();
  },

  onEnter(e){
    var saveDuration = this.saveDuration;
    if (e.keyCode == 13){
      saveDuration();
    }
  },

  render(){

    return(
      <span>
        <input id="task_hours" onKeyDown={this.onEnter} ref="hours" className="form duration hr"></input>
        <span> hr </span>
        <input id="task_mins" onKeyDown={this.onEnter} ref="minutes" className="form duration min"></input>
        <span> min </span>
        <input id="task_secs" onKeyDown={this.onEnter} ref="seconds" className="form duration sec"></input>
        <span> sec </span>
        <button id="save_duration" onClick={this.saveDuration} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleDuration} className="btn btn-default btn-sm">Cancel</button>
      </span>
    );

  }

});