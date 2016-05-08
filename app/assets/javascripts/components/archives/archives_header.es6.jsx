var ArchivesHeader = React.createClass({
  render(){
    return(
      <div className="navbar navbar-inverse">
        <div className="container-fluid">
          <ul className="nav navbar-nav">
            <li><a role="button" href="/tasks/index">Five Tee</a></li>
            <li><a role="button" href="/tasks/index">Back to Tasks</a></li>
          </ul>
        </div>
      </div>
    );
  }
});