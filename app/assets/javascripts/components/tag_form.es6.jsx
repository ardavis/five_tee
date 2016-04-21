var TagForm = React.createClass({

  componentDidMount(){
  },


  saveTag(){
    tag_id = 5;
    id = this.props.task.id;
    params = {task: {id: id, tag_id: tag_id}};
    this.props.handleUpdateTask(params);
    this.props.toggleTitle();
  },

  dropdownOrInput(){

  },

  render(){
    return(
      <div className="dropdown">
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button">
          <span className="task form tag"></span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          <li>
            <a href="javascript: void(0)">Create New Tag</a>
          </li>
          <li><div className="divider"></div></li>
          <li><a className="select_no_tag" href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
        </ul>
      </div>
    );
  }

});