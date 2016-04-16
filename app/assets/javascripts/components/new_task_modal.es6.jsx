class NewTaskModal extends React.Component{
  constructor(props){
    super(props);
    this.state = {tag_dropdown: this.props.tag_dropdown,
                  selected_task: this.props.selected_task,
                  focus_elem: null,
                  selected_tag: {name: "---------", id: null},
                  tags: this.props.tags,
                  flash: this.props.flash};
  }
  
  
  



  set_listeners(){


    $('.create_new_tag').click({self: this}, function(e){
      e.data.self.toggle_input(false);
    });

    $('.cancel_new_tag').click({self: this}, function(e){
      e.data.self.toggle_input(true);
    });

    $('.save_new_tag').click({self: this}, function(e){
      e.preventDefault();
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


    $('.new_task_due_date').click(function(e){
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


    $('.newTaskModal').on('hidden.bs.modal',{self: this},  function(e){
      e.data.self.setState({tag_dropdown: true});
      $('.day').removeClass('active');
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
        $('.new_task_tag').val(self.state.selected_tag.id);
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
    $('.new_task_due_date').off('click');
    $('.newTaskModal').off('hidden.bs.modal');
  }

  toggle_input(bool){
    this.setState({tag_dropdown: bool, flash: null});
  }

  tag_dropdown_or_input(){
    tag_dropdown = this.state.tag_dropdown;
    selected_tag = this.state.selected_tag;
    if (tag_dropdown){
      tags = this.state.tags;
      return <TagDropdown tags={tags} selected_tag={selected_tag}></TagDropdown>;
    }
    else{
      return(
        <div>
          <span>
            <input className="form-control new_tag_input"></input>
            <button className="btn btn-primary btn-sm save_new_tag">Save</button>
            <button className="btn btn-default btn-sm cancel_new_tag">Cancel</button>
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
    flash = this.props.flash;
    if (this.state.flash){
      flash = this.state.flash
    }
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

  edit_task_setter(){
    task = this.props.selected_task;
    if (task){

      $('.task_form_title').html(task.title);

      $('.new_task_title').val(task.title);

      $('.new_task_tag').val(task.tag_id);

      $('.new_task_tag').html(task.tag);

      $('.new_task_due_date').val(task.due_date);

      $('.new_task_desc').val(task.desc);

      $('.task_id_input').val(task.id);
    }
  }


  componentDidMount(){
    this.edit_task_setter();
    this.remove_listeners();
    this.set_listeners();
  }


  componentDidUpdate() {
    this.state.flash = null;
    this.remove_listeners();
    this.set_listeners();
    this.set_focus();
    if (this.state.tag_dropdown == false){
      $('.new_tag_input').focus();
    }
    this.edit_task_setter();
  }

  render(){
    return(
      <div className="newTaskModal modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal">×</button>
              <h4 className="modal-title task_form_title">New Task</h4>
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
                <input className="task_id_input" type="hidden"></input>
              </form>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-primary task_save">Save</button>
              <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
            </div>
          </div>
        </div>
      </div>
    );
  }
}