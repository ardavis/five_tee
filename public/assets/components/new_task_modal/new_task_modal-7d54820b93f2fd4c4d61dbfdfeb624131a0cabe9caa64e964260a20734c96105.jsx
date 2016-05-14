var NewTaskModal = React.createClass({

  getInitialState(){
    return({
      request_sent: false,
      flash: null
    });
  },

  componentDidMount(){
    var hideNewModal = this.props.hideNewModal;
    $('.new.task.modal').modal('toggle');
    $('.new.task.modal').on('hidden.bs.modal', function (e) {
      hideNewModal();
    });

    var klass = this;

    setTimeout(function(e){
      klass.refs.title.focus();
    }, 200);

    $(this.refs.due_date).datepicker({
      format: 'mm-dd-yyyy',
      todayHighlight: true
    });

    $(this.refs.due_date).on('change', function(){
      $('.datepicker').hide();
      klass.refs.desc.focus();
    });
  },

  componentDidUpdate(){
    if (thereAreNoErrors() && this.state.request_sent){
      $('.new.task.modal').modal('toggle');
    }
    this.state.request_sent = false;
  },

  setFlash(msg){
    this.setState({flash: msg})
  },

  saveTask(){
    this.state.flash = null;
    params = {
      task: {
        title: this.refs.title.value,
        tag_id: $('.new.task.tag').val(),
        due_date: this.refs.due_date.value,
        desc: this.refs.desc.value
      }
    };
    if (params.task.title.trim().length == 0){
      this.setState({flash: "Title cannot be blank"});
      this.refs.title.focus();
    }
    else{
      this.props.handleNewTask(params, this);
      this.state.request_sent = true;
    }
  },

  onEnter(e){
    var saveTask = this.saveTask;
    if (e.keyCode == 13){
      saveTask();
    }
  },

  flashDisplay(){
    if (this.state.flash){
      return(<div className="alert alert-danger">{this.state.flash}</div>)
    }
    else{
      return null;
    }
  },
  
  handleNewTag(params, tag_form){
    this.props.handleNewTag(params, this, tag_form);
  },
  

  render(){
    return(
      <div className="new task modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              {this.flashDisplay()}
              <h4>New Task</h4>
            </div>
            <div className="modal-body">
              <label>Title:</label>
              <input id="new_task[title]" onKeyDown={this.onEnter} ref="title" className="form-control"></input>
              <label>Tag:</label>
              <NewTaskTagForm
                tags={this.props.tags}
                handleNewTag={this.handleNewTag}
                setFlash={this.setFlash}
              ></NewTaskTagForm>
              <label>Due Date:</label>
              <input id="new_task_duedate" onKeyDown={this.onEnter} ref="due_date" placeholder="MM-DD-YYYY" className="form-control"></input>
              <label>Description:</label>
              <textarea id="new_task_desc" onKeyDown={this.onEnter} ref="desc" className="form-control"></textarea>
            </div>
            <div className="modal-footer">
              <span><a onClick={this.saveTask} className="btn btn-primary" href="javascript: void(0)" >Save</a></span>
              <span><a className="btn btn-default" href="javascript: void(0)" data-dismiss="modal">Close</a></span>
            </div>
          </div>
        </div>
      </div>
    );
  }

});