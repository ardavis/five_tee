var ArchiveTask = React.createClass({

  render(){
    return(
      <div className="row well">
        <div className="col-md-4">
          <h4><a href="javascript: void(0)">{this.props.task.title}</a></h4>
        </div>
      </div>
    );
  }

});