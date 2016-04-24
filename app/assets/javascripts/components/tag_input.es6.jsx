var TagInput= React.createClass({

  componentDidMount(){
    $('.tag.input').focus();
  },


  saveTag(){
    var name = this.refs.tag_input.value;
    if (name.trim().length > 0){
      var id = this.props.task.id;
      var params = {task: {id: id}, tag_name: name};
      this.props.handleUpdateTask(params);
      this.props.toggleTag();
    }
    else{
      this.props.setFlash("Tag name cannot be blank")
    }
  },

  render(){
    return(
      <div>
        <input ref="tag_input" className="form-control tag input"></input>
        <button onClick={this.saveTag} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTag} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});