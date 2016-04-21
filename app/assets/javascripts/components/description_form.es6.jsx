var DescriptionForm = React.createClass({
  
  componentDidMount(){
    $('.task.desc.form').val(this.props.task.desc);
    $('.task.desc.form').focus();
  },


  saveDesc(){
    desc = this.refs.desc_input.value;
    id = this.props.task.id;
    params = {task: {id: id, desc: desc}};
    this.props.handleUpdateTask(params);
    this.props.toggleDesc();
  },
  
  render(){
    return(
      <div>
        <textarea ref="desc_input" className="form-control task desc form"></textarea>
        <button onClick={this.saveDesc} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleDesc} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }
  
});