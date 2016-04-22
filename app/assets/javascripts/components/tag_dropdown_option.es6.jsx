var TagDropdownOption = React.createClass({

  setTag(){
    id = this.props.task.id;
    tag_id = this.props.tag.id;
    params = {task: {id: this.props.task.id, tag_id: this.props.tag.id}};
    this.props.handleUpdateTask(params);
    this.props.toggleTag();
  },

  render(){
    return(
      <li><a onClick={this.setTag} href="javascript: void(0)">{this.props.tag.name}</a></li>
    );
  }
});