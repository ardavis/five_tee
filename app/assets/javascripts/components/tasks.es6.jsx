class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = this.props.payload;
    this.render = this.render.bind(this);
  }

  button_action(id, state, type){
    self = this;
    $.ajax({
      type: type,
      url: `/tasks/${id}/${state}`,
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
      e.data.self.button_action(task_id, 'pause', 'GET');
    });


    $('.play_btn').click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));

      e.data.self.button_action(task_id, "start", 'GET');
    });
    
    $(".complete_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));
      e.data.self.button_action(task_id, "complete", 'GET')
    });

    $(".restart_btn").click({self: this}, function(e){
      e.preventDefault();
      task_id = e.data.self.fetch_btn_ids($(this));
      e.data.self.button_action(task_id, "restart", 'GET')
    });

    $(".delete_btn").click({self: this}, function(e){
      e.preventDefault();
      sure = confirm("Are you sure you want to delete this task?");
      if (sure){
        task_id = e.data.self.fetch_btn_ids($(this));
        e.data.self.button_action(task_id, "destroy", 'GET')
      }
    });

  }

  set_links(){
    $(".filter_link").click({self: this}, function(e){
      e.preventDefault();
      filter_id = e.data.self.fetch_link_ids($(this));
      e.data.self.link_action(filter_id, "filter", "");
    });

    $(".sort_link").click({self: this}, function(e){
      e.preventDefault();
      sort_sql = e.data.self.fetch_link_ids($(this));
      e.data.self.link_action(sort_sql, "sort", "");
    });
  }


  remove_buttons(){
    $('.pause_btn').off('click');
    $('.play_btn').off('click');
    $('.complete_btn').off('click');
    $('.delete_btn').off('click');
    $('.restart_btn').off('click');
  }


  componentDidMount(){
    this.set_buttons();
    this.set_links();
  }
  
  componentDidUpdate(){
    this.remove_buttons();
    this.set_buttons();
  }


  tasks_or_placeholder(task_rows){
    if (task_rows.incomplete.length == 0){
      task_rows.incomplete = <div className="container"><h4>You have no incomplete tasks</h4></div>
    }
    if (task_rows.complete.length == 0){
      task_rows.complete = <div className="container"><h4>You have no complete tasks</h4></div>
    }
  }



  render() {
    tasks = this.state.tasks;
    tags = this.state.tags;
    filter = this.state.filter_sort.filter;
    sort = this.state.filter_sort.sort;
    sort_options = this.state.sort_options;
    task_rows = {incomplete: [], complete: []};



    //sort_list_items = [];
    //sort_options.forEach(function (option){
    //  list_item = <li key={option.sql}><a href="#" className="sort_link" value={option.sql}>{option.label}</a></li>;
    //  sort_list_items.push(list_item);
    //});
    //
    //sort_dropdown = (
    //  <div className="dropdown">
    //    <span>Sort by:</span>
    //    <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button" id="filter_dropdown">
    //      <span>{sort.label}</span>
    //      <span className="caret"></span>
    //    </button>
    //    <ul className="dropdown-menu">
    //      {sort_list_items}
    //    </ul>
    //  </div>
    //);


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
        <FilterDropdown tags={tags} filter={filter}></FilterDropdown>
        <SortDropdown sort_options={sort_options} sort={sort}></SortDropdown>
        <h1>Tasks</h1>
        {task_rows.incomplete}
        <h1>Completed Tasks</h1>
        {task_rows.complete}
      </div>
    );
  }
}





