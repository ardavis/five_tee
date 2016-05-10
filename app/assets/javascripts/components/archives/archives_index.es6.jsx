var ArchivesIndex = React.createClass({

  getInitialState(){
    return(
      {
        archives: this.props.archives,
        selected_task: null
      }
    );
  },

  handleArchiveDelete(id){
    var params = {archive: {id: id}};
    deleteArchive(params, this);
  },
  
  selectedTaskModal(){
    if (this.state.selected_task){
      return(
        <ArchiveTaskModal
          task={this.state.selected_task}
          unselectTask={this.unselectTask}
        ></ArchiveTaskModal>);
    }
  },

  handleSelectTask(id){
    getSelectedTask(id, this);
  },

  unselectTask(){
    this.setState({selected_task: null});
  },

  archiveRows(){
    var rows = [];
    var handleArchiveDelete = this.handleArchiveDelete;
    var handleSelectTask = this.handleSelectTask;
    this.state.archives.forEach(function(archive){
      rows.push(
        <Archive
          key={archive.id}
          archive={archive}
          handleArchiveDelete={handleArchiveDelete}
          handleSelectTask={handleSelectTask}
        ></Archive>
      );
    });
    if (rows.length == 0){
      return <h4>You don't have any archives</h4>;
    }
    else{
      return rows;
    }
  },

  render(){
    return(
      <div>
        <ArchivesHeader></ArchivesHeader>
        <div className="container">
          <h1>Archives:</h1>
          {this.archiveRows()}
        </div>
        {this.selectedTaskModal()}
      </div>
    );
  }

});