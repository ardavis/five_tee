class NewTaskModal extends React.Component{
  constructor(props){
    super(props);
    this.state = {tag_dropdown: true,
                  focus_elem: null,
                  selected_tag: {name: "---------", id: null},
                  tags: this.props.tags,
                  flash: null};
  }


  set_listeners(){
    $('.create_new_tag').click({self: this}, function(e){
      e.data.self.toggle_input(false);
    });

    $('.cancel_new_tag').click({self: this}, function(e){
      e.data.self.toggle_input(true);
    });

    $('.save_new_tag').click({self: this}, function(e){
      tag_name = $('.new_tag_input').val().trim();
      if (tag_name != ""){
        e.data.self.save_new_tag(tag_name);
      }
      else{
        e.data.self.setState({flash: {danger: "Blank tag not allowed"}});
      }
    });

    $('.select_tag').click({self: this}, function(e){
      url = $(this).attr('value');
      e.data.self.select_tag(url);
    });

    $('.select_no_tag').click({self: this}, function(e){
      e.data.self.setState({selected_tag: {name: "---------", id: null}});
    });


    $('.due_date_input').click(function(e){
      e.preventDefault();
      $(this).datepicker({
        format: 'mm-dd-yyyy',
        todayHighlight: true
      });
      $(this).datepicker('show');
      $('.day').click(function(e){
        $('.datepicker').hide();
        $('.new_task_desc').focus();
      })
    });
  }
  
  save_new_tag(name){
    self = this;
    $.ajax({
      type: 'GET',
      url: `/tags/${name}/create`,
      dataType: 'json',
      success: function(data){
        self.setState({tags: data.tags,
                       selected_tag: data.selected_tag,
                       tag_dropdown: true,
                       flash: null});
        $('.datepicker').hide();
      },
      error: function(){
        self.setState({flash: {danger: `"${name}" tag already exists`}});
      }
    });
  }

  select_tag(url){
    self = this;
    $.ajax({
      type: 'GET',
      url: url,
      dataType: 'json',
      success: function(data){
        self.setState({selected_tag: data});
      }
    });
  }

  remove_listeners(){
    $('.create_new_tag').off('click');
    $('.cancel_new_tag').off('click');
    $('.save_new_tag').off('click');
    $('.select_tag').off('click');
    $('.select_no_tag').off('click');
    $('.due_date_input').off('click');
  }

  toggle_input(bool){
    this.setState({tag_dropdown: bool, flash: null});
  }

  tag_dropdown_or_input(){
    tag_dropdown = this.state.tag_dropdown;
    if (tag_dropdown){
      selected_tag = this.state.selected_tag;
      tags = this.state.tags;
      return <TagDropdown tags={tags} selected_tag={selected_tag}></TagDropdown>;
    }
    else{
      return(
        <div>
          <span>
            <input className="form-control new_tag_input"></input>
            <button className="btn btn-primary btn-sm save_new_tag">Save</button>
            <button className="btn btn-default-sm cancel_new_tag">Cancel</button>
          </span>
        </div>
      );
    }
  }

  set_focus(){
    focus_elem = this.state.focus_elem;
    if (focus_elem){
      focus_elem.focus();
    }
  }

  flash(){
    flash = this.state.flash;
    if (flash){
      if (flash.success){
        return <div className="alert alert-success">{flash.success}</div>;
      }
      else if (flash.danger){
        return <div className="alert alert-danger">{flash.danger}</div>;
      }
    }
    else{
      return null;
    }
  }






  componentDidMount(){
    this.set_listeners();
    $('.newTaskModal').modal('toggle');
    setTimeout(function(){$('.new_task_title').focus();}, 500);
  }

  componentDidUpdate() {
    this.remove_listeners();
    this.set_listeners();
    this.set_focus();
  }

  render(){
    return(
      <div className="newTaskModal modal fade" role="dialog">
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
                <input className="form-control due_date_input" placeholder="MM-DD-YYYY"></input>
                <label>Description:</label>
                <textarea className="form-control new_task_desc"></textarea>
              </form>
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