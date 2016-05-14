var TaskModal = React.createClass({

  componentDidMount(){
    var unselectTask = this.props.unselectTask;
    $('.show.task.modal').on('hidden.bs.modal', function (e) {
      unselectTask();
    });
    this.setTimer();
  },

  componentDidUpdate(){
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

  flashDisplay(){
    if (this.props.flash){
      return(
        <div className="alert alert-danger">{this.props.flash}</div>
      );
    }
  },

  toggleTitle(){
    this.setState({title_edit: !this.state.title_edit});
    if (this.state.title_edit){
      this.props.setFlash(null);
    }
  },

  toggleDesc(){
    this.setState({desc_edit: !this.state.desc_edit});
  },

  toggleTag(){
    this.setState({tag_edit: !this.state.tag_edit});
    this.props.setFlash(null);
  },

  toggleDueDate(){
    this.setState({due_date_edit: !this.state.due_date_edit});
  },

  toggleDuration(){
    this.setState({duration_edit: !this.state.duration_edit});
  },

  descLabel(){
    return(
      <div id="description_label">
        <label>Description:</label>
        {this.state.desc_edit ? '' : <span onClick={this.toggleDesc} className="btn btn-sm glyphicon glyphicon-pencil"></span>}
      </div>
    );
  },

  tagLabel(){
    return(
      <div id="tag_label">
        <label>Tag:</label>
        {this.state.tag_edit ? '' : <span onClick={this.toggleTag} className="btn btn-sm glyphicon glyphicon-pencil"></span>}
      </div>
    );
  },

  dueDateLabel(){
    return(
      <div id="due_date_label">
        <label>Due Date:</label>
        {this.state.due_date_edit ? '' : <span onClick={this.toggleDueDate} className="btn btn-sm glyphicon glyphicon-pencil"></span>}
      </div>
    );
  },

  durationLabel(){
    return(
      <div id="duration_label">
        <label>Duration:</label>
        {this.state.duration_edit ? '' : <span onClick={this.toggleDuration} className="btn btn-sm glyphicon glyphicon-pencil"></span>}
      </div>
    );
  },
  
  setTimer(){
    var task = this.props.task;
    var elem = $('.show.task.modal').find(`.timer#${task.id}`);
    if (this.isStarted() && !this.state.duration_edit){
      timerOff(elem);
      var now = Date.now() / 1000 | 0;
      var start_time = task.duration + now - task.started_at;
      console.log(start_time);
      timerOn(elem, start_time);
      $('.no.timer').html('')
    }
  },

  isStarted(){
    return this.props.task.started_at ? true : false;
  },

  titleShowOrEdit(){
    var task = this.props.task;
    var edit = this.state.title_edit;
    if (edit){
      return(
        <TitleForm
          task={task}
          toggleTitle={this.toggleTitle}
          handleUpdateTask={this.props.handleUpdateTask}
          setFlash={this.props.setFlash}
        ></TitleForm>);
    }
    else{
      return(
        <div id="title_label">
          <h4 className="modal-title">{blankSafe(task.title)}</h4>
          <span onClick={this.toggleTitle} className="btn btn-sm glyphicon glyphicon-pencil"></span>
        </div>
      );
    }
  },

  descShowOrEdit(){
    var task = this.props.task;
    var edit = this.state.desc_edit;
    if (edit){
      return(
        <DescriptionForm
          task={task}
          toggleDesc={this.toggleDesc}
          handleUpdateTask={this.props.handleUpdateTask}
        ></DescriptionForm>);
    }
    else{
      return <div>{blankSafe(task.desc)}</div>;
    }
  },


  tagShowOrEdit(){
    var task = this.props.task;
    var edit = this.state.tag_edit;
    if (edit){
      return(
        <TagForm
          task={task}
          tags={this.props.tags}
          toggleTag={this.toggleTag}
          handleUpdateTask={this.props.handleUpdateTask}
          setFlash={this.props.setFlash}
        ></TagForm>);
    }
    else{
      return <div>{task.tag ? task.tag.name : blankSafe('')}</div>;
    }
  },

  dueDateShowOrEdit(){
    var task = this.props.task;
    var edit = this.state.due_date_edit;
    if (edit){
      return(
        <DueDateForm
          task={task}
          toggleDueDate={this.toggleDueDate}
          handleUpdateTask={this.props.handleUpdateTask}
        ></DueDateForm>);
    }
    else{
      return <div>{blankSafe(task.due_date)}</div>;
    }
  },

  durationShowOrEdit(){
    var task = this.props.task;
    var edit = this.state.duration_edit;
    if (edit){
      return(
        <DurationForm
          task={task}
          toggleDuration={this.toggleDuration}
          handleUpdateTask={this.props.handleUpdateTask}
        ></DurationForm>
      );
    }
    else{
      return(
        <div><div className="current duration timer" id={task.id}>{task.duration_display}</div></div>
      );
    }
  },

  render(){

    var task = this.props.task;

    return(
      <div className="show task modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              {this.flashDisplay()}
              {this.titleShowOrEdit()}
            </div>
            <div className="modal-body">
              <div className="row">
                <div className="col-md-8">
                  {this.descLabel()}
                  {this.descShowOrEdit()}
                </div>
                <div className="col-xs-4">
                  {this.tagLabel()}
                  {this.tagShowOrEdit()}
                </div>
              </div>
              <div className="row table-bordered">
                <br/>
                <div className="col-xs-4">
                  {this.dueDateLabel()}
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
              <br/>
              <div className="row">
                <div className="col-md-8">
                  {this.durationLabel()}
                  <div>
                    {this.durationShowOrEdit()}
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