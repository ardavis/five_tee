var TasksIndex = React.createClass({

  componentWillMount: function(){
    this.state = {tasks} = this.props;
  },
  
  taskButtonPress(action, id){
    taskButtonAction(action, id, this);
  },

  incompleteRows: function(){
    var handleTaskButtons = this.taskButtonPress;
    rows = [];
    this.state.tasks.incomplete.forEach(function(task){
      rows.push(
        <IncompleteTask
          task={task}
          key={task.id}
          id={task.id}
          handleTaskButtons={handleTaskButtons}>
        </IncompleteTask>
      );
    });
    return rows;
  },
  
  completeRows: function(){
    var handleTaskButtons = this.taskButtonPress;
    rows = [];
    this.state.tasks.complete.forEach(function(task){
      rows.push(
        <CompleteTask
          task={task}
          key={task.id} 
          id={task.id}
          handleTaskButtons={handleTaskButtons}>
        </CompleteTask>
      );
    });
    return rows;
  },

  render(){
    return(
      <div className="container">
        <h1>Tasks</h1>
        <div>
          {this.incompleteRows()}
        </div>
        <h1>Completed Tasks</h1>
        <div>
          {this.completeRows()}
        </div>
      </div>
    );
   }
});

