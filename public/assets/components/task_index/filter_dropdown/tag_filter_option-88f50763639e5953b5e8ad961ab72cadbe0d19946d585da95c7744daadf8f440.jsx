var TagFilterOption = React.createClass({

  filterTag(){
    var tag = this.props.tag;
    var params = {tag: {id: tag.id, name: tag.name}};
    this.props.handleFilterTag(params);
  },

  render(){
    return(
      <li><a onClick={this.filterTag} className="dropdown-item" href="javascript: void(0)">{this.props.tag.name}</a></li>
    );
  }

});