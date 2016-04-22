var ShowTaskModal = React.createClass({

  componentDidMount(){
    var unselectTask = this.props.unselectTask;
    $('.show.task.modal').on('hidden.bs.modal', function (e) {
      unselectTask();
    });
    this.setTimer();
  },
  

  getInitialState(){
    return({
      title_edit: false,
      desc_edit: false,
      tag_edit: false,
      due_date_edit: false,
      created_at_edit: false,
      completed_at_edit: false,
      duration_edit: false
    });
  },

  toggleTitle(){
    this.setState({title_edit: !this.state.title_edit});
  },

  toggleDesc(){
    this.setState({desc_edit: !this.state.desc_edit});
  },

  toggleTag(){
    this.setState({tag_edit: !this.state.tag_edit});
  },

  toggleDueDate(){
    this.setState({due_date_edit: !this.state.due_date_edit});
  },

  setTimer(){
    var task = this.props.task;
    var elem = $('.show.task.modal').find(`.timer#${task.id}`);
    if (this.isStarted()){
      var now = Date.now() / 1000 | 0;
      var start_time = task.duration + now - task.started_at;
      timerOn(elem, start_time);
    }
    else{
      timerOff(elem);
      elem.html(task.duration_display);
    }
  },

  isStarted(){
    return this.props.task.started_at ? true : false;
  },

  descShowOrEdit(){
    var edit = this.state.desc_edit;
    if (edit){
      return(
        <DescriptionForm
          task={this.props.task} 
          toggleDesc={this.toggleDesc}
          handleUpdateTask={this.props.handleUpdateTask}
        ></DescriptionForm>);
    }
    else{
      return <div onClick={this.toggleDesc}>{task.desc}</div>;
    }
  },

  titleShowOrEdit(){
    var edit = this.state.title_edit;
    if (edit){
      return(
        <TitleForm
          task={this.props.task}
          toggleTitle={this.toggleTitle}
          handleUpdateTask={this.props.handleUpdateTask}
        ></TitleForm>);
    }
    else{
      return <h4 onClick={this.toggleTitle} className="modal-title">{task.title}</h4>;
    }
  },

  tagShowOrEdit(){
    var edit = this.state.tag_edit;
    if (edit){
      return(
        <TagForm
          task={this.props.task}
          tags={this.props.tags}
          toggleTag={this.toggleTag}
          handleUpdateTask={this.props.handleUpdateTask}
        ></TagForm>);
    }
    else{
      return <div onClick={this.toggleTag}>{task.tag ? task.tag.name : ""}</div>;
    }
  },

  dueDateShowOrEdit(){
    var edit = this.state.due_date_edit;
    if (edit){
      return(
        <DueDateForm
          task={this.props.task}
          toggleDueDate={this.toggleDueDate}
          handleUpdateTask={this.props.handleUpdateTask}
        ></DueDateForm>);
    }
    else{
      return <div onClick={this.toggleDueDate}>{task.due_date ? task.due_date : <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>}</div>;
    }
  },

  render(){

    var task = this.props.task;

    return(
      <div className="show task modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" >&times;</button>
              {this.titleShowOrEdit()}
            </div>
            <div className="modal-body">
              <div className="row">
                <div className="col-md-8">
                  <label>Description:</label>
                  {this.descShowOrEdit()}
                </div>
                <div className="col-xs-4">
                  <label>Tag:</label>
                  {this.tagShowOrEdit()}
                </div>
              </div>
              <div className="row table-bordered">
                <div className="col-xs-4">
                  <label>Due Date:</label>
                  <div>{this.dueDateShowOrEdit()}</div>
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
              <div className="row">
                <div className="col-md-8">
                  <label>Duration:</label>
                  <div className="timer" id={task.id}>
                    {task.duration_display}
                  </div>
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