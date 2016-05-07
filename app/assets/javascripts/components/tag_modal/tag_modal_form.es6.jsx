var TagModalForm = React.createClass({

  componentDidMount(){
    $(this.refs.tag_name).val(this.props.tag.name);
    this.refs.tag_name.focus();
  },

  componentDidUpdate(){
    if (thereAreNoErrors() && this.state.requestSent){
      this.props.toggleNameForm();
    }
  },
  
  saveName(){
    name = $(this.refs.tag_name).val();
    if (name.trim().length > 0){
      params = {
        tag: {
          id: this.props.tag.id,
          name: name
        }
      };
      this.props.handleUpdateTag(params);
      this.state.requestSent = true;
    }
    else{
      this.setFlash)
    }
  },

  render(){
    return(
      <div>
        <input onKeyDown={this.onEnter} ref="tag_name" className="form-control"></input>
        <button onClick={this.saveName} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleNameForm} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});