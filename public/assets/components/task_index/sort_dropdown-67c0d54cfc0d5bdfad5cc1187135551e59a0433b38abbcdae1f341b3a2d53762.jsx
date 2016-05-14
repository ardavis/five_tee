var SortDropdown = React.createClass({
  
  
  options(){
    options = [];
    handleSortSelect = this.props.handleSortSelect
    this.props.sort_options.forEach(function(option){
      options.push(
        <SortOption
          handleSortSelect={handleSortSelect}
          key={option.sql}
          option={option}
        ></SortOption>
      );
    });
    return options;
  },

  render(){
    return(
      <span>
        <p className="index_header">Sort by:</p>
        <div className="btn-group">
          <button
            type="button"
            className="btn sort btn-default dropdown-toggle"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >{this.props.sort_label}
            <div className="caret"></div>
          </button>
          <div className="dropdown-menu">
            {this.options()}
          </div>
        </div>
      </span>
    );
  }
  
});