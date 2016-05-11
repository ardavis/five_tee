var NewTaskTagInput= React.createClass({

  componentDidMount(){
    $('.tag.input').focus();
  },

  componentDidUpdate(){
    if (thereAreNoErrors() && this.state.requestSent){
      this.props.toggleTagInput();
    }
  },

  getInitialState(){
    return({requestSent: false})
  },


  saveTag(){
    var name = this.refs.tag_input.value;
    if (name.trim().length > 0){
      var params = {tag: {name: name}};
      this.props.handleNewTag(params);
      this.state.requestSent = true;
    }
    else{
      this.props.setFlash("Tag name cannot be blank");
      this.refs.tag_input.focus();
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
        <input id="new_task[tag]" onKeyDown={this.onEnter} ref="tag_input" className="form-control tag input"></input>
        <button id="save_tag" onClick={this.saveTag} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTagInput} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});