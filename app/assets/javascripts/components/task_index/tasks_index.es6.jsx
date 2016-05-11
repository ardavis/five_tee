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

      // Tag Modal states

      tag_modal: false,

      tag_modal_flash: null,

      // Filter tag state

      filter_tag: {name: 'All Tags'},

      // Sort state

      sort_options: this.props.sort_options,

      sort_label: 'Newest to Oldest',

      // Reset Modal State

      reset_modal: false

    });
  },


  handle_new_task_modal(){
    this.setState({new_task_modal: true})
  },

  handleTagModal(){
    this.setState({tag_modal: true})
  },

  handleNewTask(params, new_task_form){
    newTask(params, this, new_task_form);
  },

  hideNewModal(){
    this.setState({new_task_modal: false})
  },

  hideTagModal(){
    this.setState({tag_modal: false})
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

  handleUpdateTag(params){
    updateTag(params, this)
  },

  handleTagDelete(id){
    deleteTag(id, this)
  },

  handleFilterTag(params){
    updateFilterTag(params, this);
  },

  handleSortSelect(option){
    updateSort(option, this)
  },

  handleArchive(){
    proceed = confirm("Are you sure you want to archive the currently shown tasks?");
    if (proceed){
      archiveTasks(this);
    }
  },

  handleTasksReset(){
    resetTasks(this);
  },

  handleArchiveReset(){
    archiveResetTasks(this);
  },

  handleDownload(){
    downloadTasks();
  },

  toggleResetModal(){
    this.setState({reset_modal: !this.state.reset_modal})
  },

  setFlash(msg){
    this.setState({flash: msg});
  },

  setTagFlash(msg){
    this.setState({tag_modal_flash: msg});
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

  tagModal(){
    if (this.state.tag_modal){
      return(
        <TagModal
          tags={this.state.tags}
          flash={this.state.tag_modal_flash}
          hideTagModal={this.hideTagModal}
          handleTagDelete={this.handleTagDelete}
          handleUpdateTag={this.handleUpdateTag}
          setFlash={this.setTagFlash}
        ></TagModal>
      );
    }
    else{
      return null;
    }
  },

  resetModal(){
    if (this.state.reset_modal){
      return(
        <ResetTasksModal
          toggleResetModal={this.toggleResetModal}
          handleTasksReset={this.handleTasksReset}
          handleArchiveReset={this.handleArchiveReset}
        ></ResetTasksModal>
      )
    }
  },

  render(){
    return(
      <div>
        <TasksHeader
          handle_new_task_modal={this.handle_new_task_modal}
          handleTagModal={this.handleTagModal}
          handleDownload={this.handleDownload}
        ></TasksHeader>
        <div className="container">
          <div className="row">
            <div className="col-md-4">
              <h1 className="index_header">Tasks</h1>
            </div>
            <div className="col-md-8 dropdowns">
              <TagFilterDropdown
                handleFilterTag={this.handleFilterTag}
                filter_tag={this.state.filter_tag}
                tags={this.state.tags}
              ></TagFilterDropdown>
              <SortDropdown
                sort_options={this.state.sort_options}
                sort_label={this.state.sort_label}
                handleSortSelect={this.handleSortSelect}
              ></SortDropdown>
              <span className="archive-btns">
                <button onClick={this.handleArchive} className="btn btn-default">Archive Tasks</button>
                <button onClick={this.toggleResetModal} className="btn btn-danger">Reset All Tasks</button>
              </span>
            </div>
          </div>
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
        {this.tagModal()}
        {this.resetModal()}
      </div>
    );
   }
});

