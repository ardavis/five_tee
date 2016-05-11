var TitleForm = React.createClass({

  componentDidMount(){
    $('.task.title.form').val(this.props.task.title);
    $('.task.title.form').focus();
  },

  componentDidUpdate(){
    if (thereAreNoErrors() && this.state.requestSent){
      this.props.toggleTitle();
    }
  },

  getInitialState(){
    return({requestSent: false})
  },
  
  saveTitle(){
    var title = this.refs.title_input.value;
    if (title.trim().length > 0){
      var id = this.props.task.id;
      var params = {task: {id: id, title: title}};
      this.props.handleUpdateTask(params);
      this.setState({requestSent: true});
    }
    else{
      this.props.setFlash("Title cannot be blank");
    }
  },

  onEnter(e){
    var saveTitle = this.saveTitle;
    if (e.keyCode == 13){
      saveTitle();
    }
  },

  render(){
    return(
      <div>
        <input id="task_title" onKeyDown={this.onEnter} ref="title_input" className="form-control task title form"></input>
        <button id="save_title" onClick={this.saveTitle} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTitle} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});