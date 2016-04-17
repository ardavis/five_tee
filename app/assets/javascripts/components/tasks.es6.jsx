class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = this.props.payload;
    this.render = this.render.bind(this);
  }

  button_action(id, state){
    self = this;
    $.ajax({
      type: "POST",
      url: `/tasks/${state}`,
      data: {task: {id: id}},
      dataType: 'json',
      success: function(data){
        self.setState(data);
      }
    });
  }

  link_action(id_sql, filter_sort, type){
    self = this;
    $.ajax({
      type: "GET",
      url: `/session/${id_sql}/update_${filter_sort}`,
      dataType: 'json',
      success: function(data){
        self.setState(data);
      }
    });
  }

  fetch_btn_ids(elem){
    id = elem.parent().parent().parent().attr('value');
    return id;
  }

  fetch_link_ids(elem){
    id = elem.attr('value');
    return id;
  }

  set_buttons(){

    $('.pause_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));
      e.data.self.button_action(task_id, 'pause');
    });


    $('.play_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));

      e.data.self.button_action(task_id, "start");
    });
    
    $(".complete_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));
      e.data.self.button_action(task_id, "complete")
    });

    $(".restart_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));
      e.data.self.button_action(task_id, "restart")
    });

    $(".delete_btn").click({self: this}, function(e){
      e.preventDefault();
      sure = confirm("Are you sure you want to delete this task?");
      if (sure){
        task_id = e.data.self.fetch_btn_ids($(this));
        e.data.self.button_action(task_id, "destroy")
      }
    });
  }


  task_modal_init(){
    this.setState({flash: null});
    $('.task_form_modal_title').html('New Task');
    $('.task_form_title').val('');
    $('.task_form_tag').val('');
    $('.task_form_tag').html('---------');
    $('.task_form_due_date').val('');
    $('.task_form_desc').val('');
    $('.task_form_id').val('');
    $('.day').removeClass('active');
  }


  task_form_modal(){
    if (!!this.state.selected_tag){
      this.task_modal_init();
    }
    $('.taskFormModal').modal('toggle');
    setTimeout(function(){$('.task_form_title').focus();}, 500);
    this.remove_links();
    this.set_links();
  }


  set_links(){

    this_class = this;

    $(".trigger_modal_task_form").click(function(e){
      this_class.state.selected_task = null;
      this_class.task_modal_init();
      this_class.task_form_modal();
    });

    $('.task_save').click({self: this}, function(e){
      params = this_class.task_params_hash();
      if (params.id == 0){
        this_class.new_task_save(params);
      }
      else{
        this_class.edit_task_save(params);
      }
    });

    $(".filter_link").click({self: this}, function(e){
      e.preventDefault();
      filter_id = e.data.self.fetch_link_ids($(this));
      this_class.link_action(filter_id, "filter", "");
    });

    $(".sort_link").click({self: this}, function(e){
      e.preventDefault();
      sort_sql = e.data.self.fetch_link_ids($(this));
      this_class.link_action(sort_sql, "sort", "");
    });

    $('.edit_task_link').click({self: this},function(e){
      $('.showModal').modal('toggle');
      this_class.setState({selected_task: show_task, flash: null});
      $('.taskFormModal').modal('toggle');
    });


    $(".show_link").click({self: this}, function(e){
      task_id = e.data.self.fetch_id($(this));
      this_class.update_modal(id);
    });
    
    $('.edit_duration_link').click({self: this}, function(e){
      $('.edit_duration_save').click({self: e.data.self}, function(e){
        e.data.self.edit_duration();
      });
    });



  }

  update_modal(id){
    self = this;
    $.ajax({
      type: "POST",
      url: `/tasks/show`,
      data: {task: {id: id}},
      dataType: 'json',
      success: function(data){
        self.setState({show_task: data});
        $('.showModal').modal('toggle');
      }
    });
  }


  fetch_id(elem){
    id = elem.attr('value');
    return id;
  }


  remove_buttons(){
    $('.pause_btn').off('click');
    $('.play_btn').off('click');
    $('.complete_btn').off('click');
    $('.delete_btn').off('click');
    $('.restart_btn').off('click');
  }

  remove_links(){
    $('.filter_link').off('click');
    $('.sort_link').off('click');
    $('.task_save').off('click');
    $('.trigger_modal_task_form').off('click');
    $('.editTaskModal').off('click');
    $('.show_link').off('click');
    $('.edit_task_link').off('click');
  }

  
  componentDidMount(){
    this.set_buttons();
    this.set_links();
  }
  
  componentDidUpdate(){
    this.remove_links();
    this.remove_buttons();
    this.set_buttons();
    this.set_links();
  }


  tasks_or_placeholder(task_rows){
    if (task_rows.incomplete.length == 0){
      task_rows.incomplete = <div className="container"><h4>You have no incomplete tasks</h4></div>
    }
    if (task_rows.complete.length == 0){
      task_rows.complete = <div className="container"><h4>You have no complete tasks</h4></div>
    }
  }


  task_params_hash(){
    params = {
      title: $('.task_form_title').val(),
      tag_id: +$('.task_form_tag').val(),
      due_date: $('.task_form_due_date').val(),
      desc: $('.task_form_desc').val(),
      id: +$('.task_form_id').val()
    };
    return params;
  }


  new_task_save(params){
    url = `/tasks/create/`;
    self = this;
    $.ajax({
      type: 'POST',
      url: url,
      data: {task: params},
      dataType: 'json',
      success: function(data){
        self.setState(data);
        self.setState({flash: {success: "Task successfuly created."}});
        $('.task_form_title').val('');
        $('.task_form_tag').val('');
        $('.task_form_tag').html('---------');
        $('.task_form_due_date').val('');
        $('.task_form_desc').val('');
        $('.day').removeClass('active');
      },
      error: function(){
        self.setState({flash: {danger: `"${params.title}" task already exists.`}})
      }
    });
  }

  edit_task_save(params){
    url = `/tasks/update/`;
    self = this;
    $.ajax({
      type: 'POST',
      url: url,
      data: {task: params},
      dataType: 'json',
      success: function(data){
        self.setState(data);
        $('.taskFormModal').modal('toggle');
      },
      error: function(){
        self.setState({flash: {danger: `"${params.title}" task already exists.`}})
      }
    });
  }

  edit_duration(){
    id = $('.task_form_id').val();
    duration = +$('.duration_input.hours').val() * 3600;
    duration += +$('.duration_input.mins').val()  * 60;
    duration += +$('.duration_input.secs').val() ;

    $.ajax({
      type: "POST",
      url: '/tasks/update/',
      data: {task: {id: id, duration: duration}},
      dataType: 'json',
      success: function(data){
        self.setState(data);
      }
    })
  }

  show_modal(){
    show_task = this.state.show_task;
    if (show_task){
      return <ShowModal task={show_task}></ShowModal>
    }
    else{
      return ""
    }
  }

  
  


  render() {
    tasks = this.state.tasks;
    tags = this.state.tags;
    filter_sort = this.state.filter_sort;
    filter = filter_sort.filter;
    sort = filter_sort.sort;
    sort_options = this.state.sort_options;
    task_rows = {incomplete: [], complete: []};
    flash = this.state.flash;
    selected_task = this.state.selected_task;
    show_task = this.state.show_task;


    tasks.incomplete.forEach(function (task){
      task_row = <IncompleteTask task={task} key={task.id}></IncompleteTask>;
      task_rows.incomplete.push(task_row);
    });

    tasks.complete.forEach(function (task){
      task_row = <CompleteTask task={task} key={task.id}></CompleteTask>;
      task_rows.complete.push(task_row);
    });

    this.tasks_or_placeholder(task_rows);

    return(
      <div className="incomplete_tasks">
        <TaskFormModal selected_task={show_task} tags={tags} flash={flash}></TaskFormModal>
        {this.show_modal()}
        <FilterDropdown tags={tags} filter={filter}></FilterDropdown>
        <SortDropdown sort_options={sort_options} filter_sort={filter_sort}></SortDropdown>
        <h1>Tasks</h1>
        {task_rows.incomplete}
        <h1>Completed Tasks</h1>
        {task_rows.complete}
      </div>
    );
  }
}





