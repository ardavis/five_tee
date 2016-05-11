var NewTaskTagDropdownOption = React.createClass({

  setTag(){
    var tag = {
      name: this.props.tag.name,
      id: this.props.tag.id
    };
    this.props.handleTagSelect(tag);
  },

  render(){
    return(
      <li><a onClick={this.setTag} href="javascript: void(0)">{this.props.tag.name}</a></li>
    );
  }
});