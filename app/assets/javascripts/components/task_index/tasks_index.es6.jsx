var TasksIndex = React.createClass({

  getInitialState(){
    return(
    {
      // General states
      tasks: this.props.tasks,
      selected_task: this.props.selected_task,
      tags: this.props.tags,
      flash: null,

      // New Task Modal states
      new_task_modal: false,

      // Task modal states
      
    });
  },


  handle_new_task_modal(){
    this.setState({new_task_modal: true})
  },

  
  handleNewTask(params, new_task_form){
    newTask(params, this, new_task_form);
  },

  hideNewModal(){
    this.setState({new_task_modal: false})
  },

  handleTaskButtons(action, id){
    taskButtonAction(action, id, this);
  },

  handleTaskShow(id){
    getSelectedTask(id, this);
  },
  
  unselectTask(){
    this.setState({selected_task: null, flash: null})
  },
  
  handleUpdateTask(params){
    updateTask(params, this);
  },
  
  handleNewTag(params, new_task_modal, tag_form){
    newTag(params, this, new_task_modal, tag_form);
  },
  
  setFlash(msg){
    this.setState({flash: msg});
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
    if (rows.length > 0){
      return rows;
    }
    else{
      return <h4>You have no incompleted tasks</h4>
    }
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
    if (rows.length > 0){
      return rows;
    }
    else{
      return <h4>You have no completed tasks</h4>
    }
  },

  taskModal(){
    var task = this.state.selected_task;
    var tags = this.state.tags;
    if (task){
      return( 
        <TaskModal
          task={task}
          tags={tags}
          unselectTask={this.unselectTask}
          handleUpdateTask={this.handleUpdateTask}
          setFlash={this.setFlash}
          flash={this.state.flash}
        ></TaskModal>);
    }
    else{
      return "";
    }
  },
  
  newTaskModal(){
    if (this.state.new_task_modal){
      return(
        <NewTaskModal
          tags={this.state.tags}
          handleNewTask={this.handleNewTask}
          hideNewModal={this.hideNewModal}
          handleNewTag={this.handleNewTag}
        ></NewTaskModal>
      );
    }
    else{
      return null;
    }
  },

  render(){
    return(
      <div>
        <Header handle_new_task_modal={this.handle_new_task_modal}></Header>
        <div className="container">
          <h1>Tasks</h1>
          <div id="incomplete_tasks">
            {this.incompleteRows()}
          </div>
          <h1>Completed Tasks</h1>
          <div id="completed_tasks">
            {this.completeRows()}
          </div>
        </div>
        {this.taskModal()}
        {this.newTaskModal()}
      </div>
    );
   }
});

