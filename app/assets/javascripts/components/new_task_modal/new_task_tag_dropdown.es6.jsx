var NewTaskTagDropdown = React.createClass({


  tagOptions(){
    var tags = this.props.tags;
    var tag_options = [];
    var handleTagSelect = this.props.handleTagSelect;
    tags.forEach(function(tag){
      option = (
        <NewTaskTagDropdownOption
          key={tag.id}
          tag={tag}
          handleTagSelect={handleTagSelect}
        ></NewTaskTagDropdownOption>
      );
      tag_options.push(option);
    });
    return tag_options;
  },

  setNoTag(){
    this.props.handleTagSelect(null);
  },

  render(){
    return(
      <div className="dropdown">
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button">
          <span id="tag_dropdown" value={this.props.tag ? this.props.tag.id : null} className="new task tag">{this.props.tag ? this.props.tag.name : '--------'}</span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          <li>
            <a onClick={this.props.toggleTagInput} href="javascript: void(0)">Create New Tag</a>
          </li>
          <li><div className="divider"></div></li>
          <li><a onClick={this.setNoTag} href="javascript: void(0)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
          {this.tagOptions()}
        </ul>
      </div>
    );
  }

});