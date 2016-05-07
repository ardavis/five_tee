var Header = React.createClass({
  render(){
    return(
      <div className="navbar navbar-inverse">
        <div className="container-fluid">
          <ul className="nav navbar-nav">
            <li><a role="button" href="javascript: void(0)">Five Tee</a></li>
            <li><a onClick={this.props.handle_new_task_modal} role="button" href="javascript: void(0)">New Task</a></li>
            <li><a onClick={this.props.handleTagModal} role="button" href="javascript: void(0)">Manage Tags</a></li>
            <li><a role="button" href="javascript: void(0)">View Archives</a></li>
          </ul>
        </div>
      </div>
    );
  }
});