class DurationForm extends React.Component{
  constructor(props){
    super(props);
  }

  init(){
    task = this.props.task;
    if (task){
      if ($('.index-task-running').attr('value') == task.id){
        duration = $('.index-task-running').html().split(" ");
        hours = duration[0];
        mins = duration[2];
        secs = duration[4];
      }
      else{
        hours = Math.floor(task.duration / 3600);
        mins = Math.floor(task.duration / 60 % 60);
        secs = task.duration % 60;
      }
      $('.duration_input.hours').val(hours);
      $('.duration_input.mins').val(mins);
      $('.duration_input.secs').val(secs);
    }
  }



  componentDidUpdate(){
    this.init();
  }


  render(){
    return(
      <div>
        <label>Duration:</label>
        <div>
          <input className="duration_input hours" type="number"></input>
          <span> hours </span>
          <input maxLength="2" className="duration_input mins" type="number"></input>
          <span> mins </span>
          <input maxLength="2" className="duration_input secs" type="number"></input>
          <span> secs </span>
          <button className="btn btn-primary btn-sm edit_duration_save">Save</button>
          <button className="btn btn-default btn-sm edit_duration_close">Cancel</button>
        </div>
      </div>
    );

  }

}