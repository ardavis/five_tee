var Archive = React.createClass({

  incompleteTasks(){
    tasks = [];
    console.log(this.props.archive);
    this.props.archive.tasks.incomplete.forEach(function(task){
      task = <ArchiveTask key={task.id} task={task}></ArchiveTask>;
      tasks.push(task);
    });
    return tasks.length == 0 ? <h4>No Incomplete Tasks</h4> : tasks;
  },

  render(){
    return(
      <div>
        <div className="row well">
          <div className="col-md-6">
            <h3
              data-target={`#archive-${this.props.archive.id}`}
              data-toggle="collapse"
              type="button"
            >
              <a
                href="javascript: void(0)">
                {this.props.archive.created_at_display}
              </a>
            </h3>
          </div>
          <div className="col-md-1 pull-right">
            <a href="javascript: void(0)" className="delete-archive btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
        <div className="row collapse" id={`archive-${this.props.archive.id}`}>
          <div className="scoll table-bordered">
            <h3>Incomplete Tasks</h3>
            {this.incompleteTasks()}
          </div>
        </div>
      </div>
    );
  }

});