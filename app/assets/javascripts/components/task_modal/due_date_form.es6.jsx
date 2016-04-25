var DueDateForm= React.createClass({

  componentDidMount(){
    $('.task.due.date.form').val(this.props.task.due_date);
    $('.task.due.date.form').datepicker({
      format: 'mm-dd-yyyy',
      todayHighlight: true
    });

    $('.task.due.date.form').on('change', function(){
      $('.datepicker').hide();
    });

    $('.task.due.date.form').focus();
  },


  saveDueDate(){
    var due_date = this.refs.due_date_input.value;
    var id = this.props.task.id;
    var params = {task: {id: id, due_date: due_date}};
    this.props.handleUpdateTask(params);
    this.props.toggleDueDate();
  },

  onEnter(e){
    var saveDueDate = this.saveDueDate;
    if (e.keyCode == 13){
      saveDueDate();
    }
  },

  render(){
    return(
      <div>
        <input onKeyDown={this.onEnter} ref="due_date_input" className="form-control task due date form"></input>
        <button onClick={this.saveDueDate} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleDueDate} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});