var TitleForm = React.createClass({

  componentDidMount(){
    $('.task.title.form').val(this.props.task.title);
    $('.task.title.form').focus();
  },


  saveTitle(){
    title = this.refs.title_input.value;
    id = this.props.task.id;
    params = {task: {id: id, title: title}};
    this.props.handleUpdateTask(params);
    this.props.toggleTitle();
  },

  render(){
    return(
      <div>
        <input ref="title_input" className="form-control task title form"></input>
        <button onClick={this.saveTitle} className="btn btn-primary btn-sm">Save</button>
        <button onClick={this.props.toggleTitle} className="btn btn-default btn-sm">Cancel</button>
      </div>
    );
  }

});