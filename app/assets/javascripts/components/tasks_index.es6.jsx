var TasksIndex = React.createClass({

  componentWillMount(){
    this.state = {tasks, selected_task, tags} = this.props;
  },


  handleTaskButtons(action, id){
    taskButtonAction(action, id, this);
  },

  handleTaskShow(id){
    getSelectedTask(id, this);
  },
  
  unselectTask(){
    this.setState({selected_task: null})
  },
  
  handleUpdateTask(params){
    updateTask(params, this);
  },
  

  incompleteRows(){
    var handleTaskButtons = this.handleTaskButtons;
    var handleTaskShow = this.handleTaskShow;
    var rows = [];
    this.state.tasks.incomplete.forEach(function(task){
      rows.push(
        <IncompleteTask
          task={task}
          key={task.id}
          id={task.id}
          handleTaskButtons={handleTaskButtons}
          handleTaskShow={handleTaskShow}>
        </IncompleteTask>
      );
    });
    return rows;
  },
  
  completeRows(){
    var handleTaskButtons = this.handleTaskButtons;
    var handleTaskShow = this.handleTaskShow;
    var rows = [];
    this.state.tasks.complete.forEach(function(task){
      rows.push(
        <CompleteTask
          task={task}
          key={task.id} 
          id={task.id}
          handleTaskButtons={handleTaskButtons}
          handleTaskShow={handleTaskShow}>
        </CompleteTask>
      );
    });
    return rows;
  },

  showTaskModal(){
    var task = this.state.selected_task;
    var tags = this.state.tags;
    if (task){
      return( 
        <ShowTaskModal 
          task={task}
          tags={tags}
          unselectTask={this.unselectTask}
          handleUpdateTask={this.handleUpdateTask}
        ></ShowTaskModal>);
    }
    else{
      return "";
    }
  },

  render(){
    return(
      <div>
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
        {this.showTaskModal()}
      </div>
    );
   }
});

