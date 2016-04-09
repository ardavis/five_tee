class Tasks extends React.Component {

  constructor(props){
    super(props);
  }

  componentWillMount(){
    $('.pause_btn').click(function(e){
      e.preventDefault();
      task_id = $(this).data('val');
      $.ajax({
        type: "GET",
        url: `/tasks/${task_id}/pause`
      });
      alert("fins!");
    });


    $('.play_btn').click(function(e){
      e.preventDefault();
      task_id = $(this).data('val');
      $.ajax({
        type: "GET",
        url: `/tasks/${task_id}/start`
      });
      alert("fins!");
    });
  }

  render() {

    tasks = this.props.tasks;
    type = this.props.type;

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





