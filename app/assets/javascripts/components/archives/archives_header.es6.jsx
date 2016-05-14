var ArchivesHeader = React.createClass({
  render(){
    return(
      <div className="navbar navbar-inverse">
        <div className="container-fluid">
          <ul className="nav navbar-nav">
            <li><a role="button" href="/">Five Tee</a></li>
            <li><a role="button" href="/">Back to Tasks</a></li>
            <li><a role="button" href="/users/sign_out">Sign Out</a></li>
          </ul>
        </div>
      </div>
    );
  }
});