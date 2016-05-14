var Archive = React.createClass({

  incompleteTasks(){
    var tasks = [];
    var handleSelectTask = this.props.handleSelectTask;
    this.props.archive.tasks.incomplete.forEach(function(task){
      task = <ArchiveTask handleSelectTask={handleSelectTask} key={task.id} task={task}></ArchiveTask>;
      tasks.push(task);
    });
    return tasks.length == 0 ? <h4>No Incomplete Tasks</h4> : tasks;
  },

  completeTasks(){
    var tasks = [];
    var handleSelectTask = this.props.handleSelectTask;
    this.props.archive.tasks.complete.forEach(function(task){
      task = <ArchiveTask handleSelectTask={handleSelectTask} key={task.id} task={task}></ArchiveTask>;
      tasks.push(task);
    });
    return tasks.length == 0 ? <h4>No Complete Tasks</h4> : tasks;
  },
  
  deleteArchive(){
    var proceed = confirm('Are you sure you want to delete this archive?');
    if (proceed){
      this.props.handleArchiveDelete(this.props.archive.id);
    }
  },
  
  download(){
    var params = {archive: {id: this.props.archive.id}};
    downloadArchive(params);
  },

  render(){
    return(
      <div className="archive">
        <div className="archive-row row well">
          <div className="col-md-6">
            <h3
              className="archive-title"
              data-target={`#archive-${this.props.archive.id}`}
              data-toggle="collapse"
              type="button">
              <a
                href="javascript: void(0)">
                {this.props.archive.created_at_display}
              </a>
            </h3>
          </div>
          <div className="col-md-3 pull-right archive-delete">
            <a href={`/archives/${this.props.archive.id}/download`} className="download archive btn btn-default">Download</a>
            <a onClick={this.deleteArchive} href="javascript: void(0)" className="delete-archive btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
        <div className="archive-collapse row collapse" id={`archive-${this.props.archive.id}`}>
          <div className="table-bordered box-height scroll">
            <div></div>
            <h3>Incomplete Tasks</h3>
            {this.incompleteTasks()}
            <h3>Completed Tasks</h3>
            {this.completeTasks()}
          </div>
        </div>
      </div>
    );
  }

});