class Tasks extends React.Component {

  constructor(props){
    super(props);
  }

  render() {

    tasks = this.props.tasks;

    task_rows = [];



    tasks.forEach(function (task){
      task_row = <Task task={task}></Task>;
      task_rows.push(task_row);
    });


    return(<div>start{task_rows}end</div>);
  }
}





