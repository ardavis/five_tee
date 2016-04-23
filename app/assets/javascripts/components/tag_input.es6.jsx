var TagInput= React.createClass({

  componentDidMount(){
    $('.tag.input').focus();
  },


  saveTag(){
    var name = this.refs.tag_input.value;
    var params = {tag: {id: id, name: name}};
    this.props.handleNewTag(params);
    this.props.toggleTagInput();
  },

  render(){
    return(
      <div>
        <input ref="tag_input" className="form-control tag input"></input>
        <button onClick={this.saveTag} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTagInput} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});