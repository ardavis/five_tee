var TagFilterDropdown = React.createClass({

  tagFilterOptions(){
    handleFilterTag = this.props.handleFilterTag;
    options = [];
    this.props.tags.forEach(function(tag){
      options.push(
        <TagFilterOption
          handleFilterTag={handleFilterTag}
          key={tag.id}
          tag={tag}
        ></TagFilterOption>
      );
    });

    return options;
  },
  
  filterAllTags(){
    params = {tag: {id: null, name: "All Tags"}};
    this.props.handleFilterTag(params)
  },


  render(){
    return(
      <span>
        <p className="index_header">Filter by:</p>
        <div className="btn-group">
          <button
            type="button"
            className="btn btn-default dropdown-toggle"
            data-toggle="dropdown"
            aria-haspopup="true"
            aria-expanded="false"
          >{this.props.filter_tag.name}
            <div className="caret"></div>
          </button>
          <div className="dropdown-menu">
            <li><a onClick={this.filterAllTags} href="javascript: void(0)">All Tags</a></li>
            <div className="divider"></div>
            {this.tagFilterOptions()}
          </div>
        </div>
      </span>
    );
  }

});