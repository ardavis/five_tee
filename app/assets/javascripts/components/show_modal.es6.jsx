class ShowModal extends React.Component{
  constructor(props){
    super(props);
    this.state = {task} = this.props;
  }

  update_modal(id){
    self = this;
    $.ajax({
      type: "GET",
      url: `/tasks/${id}/show`,
      dataType: 'json',
      success: function(data){
        self.setState({task: data});
        $('.showModal').modal('toggle');
      }
    });
  }

  fetch_id(elem){
    id = elem.attr('value');
    return id;
  }

  set_link(){
    $(".show_link").click({self: this}, function(e){
      task_id = e.data.self.fetch_id($(this));
      e.data.self.update_modal(id);
    });
  }

  componentDidMount(){
    this.set_link();
  }

  render(){
    task = this.state.task;


    return(
      <div className="showModal modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">×</button>
              <h4 className="modal-title">{task.title}</h4>
            </div>
            <div className="modal-body">
              <p>Some text in the modal.</p>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}