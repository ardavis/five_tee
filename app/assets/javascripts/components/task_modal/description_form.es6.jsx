var DescriptionForm = React.createClass({
  
  componentDidMount(){
    $('.task.desc.form').val(this.props.task.desc);
    $('.task.desc.form').focus();
  },


  saveDesc(){
    var desc = this.refs.desc_input.value;
    var id = this.props.task.id;
    var params = {task: {id: id, desc: desc}};
    this.props.handleUpdateTask(params);
    this.props.toggleDesc();
  },

  onEnter(e){
    var saveDesc = this.saveDesc;
    if (e.keyCode == 13){
      saveDesc();
    }
  },
  
  render(){
    return(
      <div>
        <textarea id="task_description" onKeyDown={this.onEnter} ref="desc_input" className="form-control task desc form"></textarea>
        <button id="save_description" onClick={this.saveDesc} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleDesc} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }
  
});