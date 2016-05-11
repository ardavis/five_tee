var SortOption = React.createClass({
  
  sortSelect(){
    this.props.handleSortSelect(this.props.option)
  },


  render(){
    return(
      <li><a onClick={this.sortSelect} className="dropdown-item" href="javascript: void(0)">{this.props.option.label}</a></li>
    );
  }

});