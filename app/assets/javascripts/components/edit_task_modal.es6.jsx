class EditTaskModal extends React.Component{
  constructor(props){
    super(props);

  }


  render(){
    return(
      <div className="editTaskModal modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">×</button>
              <h4 className="modal-title">New Task</h4>
            </div>
            <div className="modal-body">
              <form className="simple_form">
                {this.flash()}
                <label>Title:</label>
                <input className="form-control new_task_title"></input>
                <label>Tag:</label>
                {this.tag_dropdown_or_input()}
                <label>Due Date:</label>
                <input className="form-control new_task_due_date" placeholder="MM-DD-YYYY"></input>
                <label>Description:</label>
                <textarea className="form-control new_task_desc"></textarea>
              </form>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-primary new_task_save">Save</button>
              <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}