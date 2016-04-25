var Header = React.createClass({


  render(){
    return(
      <div className="navbar navbar-inverse">
        <div className="container-fluid">
          <ul className="nav navbar-nav">
            <li><a href="javascript: void(0)">Five Tee</a></li>
            <li><a href="javascript: void(0)">Manage Tags</a></li>
            <li><a href="javascript: void(0)">View Archives</a></li>
            <li className="dropdown">
              <button className="dropdown-toggle" type="button" data-toggle="dropdown" href="javascript: void(0)">Five Tee</button>
            </li>
          </ul>
        </div>
      </div>
    );
  }

});