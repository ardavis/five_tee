class Tasks extends React.Component {

  constructor(props){
    super(props);
    this.state = {tasks, type} = this.props;
  }

  toggle_task(id, state){
    get(`/tasks/${id}/${state}`);
    alert("fin!");
  }

  handle_click(){

  }


  componentWillMount(){




    $('.pause_btn').click(function(e){
      e.preventDefault();
      task_id = $(this).data('val');
      this.super.toggle_task(task_id, 'pause');
    });

    $('.play_btn').click({self: this}, this.handle_click);

    // $('.play_btn').click(self: this, function(e){
    //   e.preventDefault();
    //   task_id = $(this).data('val');
    //   e.toggle_task(task_id, 'start');
    // });


//     $("some selector").click({param1: "Hello", param2: "World"}, cool_function);
//
// // in your function, just grab the event object and go crazy...
//     function cool_function(event){
//       alert(event.data.param1);
//       alert(event.data.param2);
    }
  }







  render() {

    tasks = this.state.tasks;
    type = this.state.type;

    task_rows = [];

    if (type == 'incomplete'){
      tasks.forEach(function (task){
        task_row = <IncompleteTask task={task}></IncompleteTask>;
        task_rows.push(task_row);
      });
    }
    else if (type == 'complete'){
      tasks.forEach(function (task){
        task_row = <CompleteTask task={task}></CompleteTask>;
        task_rows.push(task_row);
      });
    }




    return(<div>{task_rows}</div>);
  }
}





