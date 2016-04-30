var TagInput= React.createClass({

  componentDidMount(){
    $('.tag.input').focus();
  },

  componentDidUpdate(){
    if (thereAreNoErrors() && this.state.requestSent){
      this.props.toggleTag();
    }
  },

  getInitialState(){
    return({requestSent: false})
  },


  saveTag(){
    var name = this.refs.tag_input.value;
    if (name.trim().length > 0){
      var id = this.props.task.id;
      var params = {task: {id: id}, tag_name: name};
      this.props.handleUpdateTask(params);
      this.state.requestSent = true;
    }
    else{
      this.props.setFlash("Tag name cannot be blank")
    }
  },

  onEnter(e){
    var saveTag = this.saveTag;
    if (e.keyCode == 13){
      saveTag();
    }
  },

  render(){
    return(
      <div>
        <input id="task_tag" onKeyDown={this.onEnter} ref="tag_input" className="form-control tag input"></input>
        <button id="save_tag" onClick={this.saveTag} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTag} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});