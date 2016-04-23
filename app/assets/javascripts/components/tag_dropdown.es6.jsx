var TagDropdown = React.createClass({
  
  
  tagOptions(){
    var toggleTag = this.props.toggleTag;
    var handleUpdateTask = this.props.handleUpdateTask;
    var tags = this.props.tags;
    var task = this.props.task;
    var tag_options = [];
    tags.forEach(function(tag){
      option = (
        <TagDropdownOption
          key={tag.id}
          tag={tag}
          task={task}
          toggleTag={toggleTag}
          handleUpdateTask={handleUpdateTask}
        ></TagDropdownOption>
      );
      tag_options.push(option);
    });
    return tag_options;
  },

  render(){
    return(
      <div className="dropdown">
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button">
          <span value={this.props.task.tag ? this.props.task.tag.id : null} className="task form tag">{this.props.task.tag ? this.props.task.tag.name : '--------'}</span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          <li>
            <a href="javascript: void(0)">Create New Tag</a>
          </li>
          <li><div className="divider"></div></li>
          <li><a className="select_no_tag" href="javascript: void(0)">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
          {this.tagOptions()}
        </ul>
      </div>
    );
  }

});