var Tag = React.createClass({
  
  getInitialState(){
    return({
      edit_name: false
    });
  },
  

  delete(){
    certain = confirm("Are you sure you want to delete this tag?");
    if (certain){
      this.props.handleTagDelete(this.props.tag.id)
    }
  },
  
  toggleNameForm(){
    this.setState({edit_name: !this.state.edit_name})
  },
  
  tagNameOrEdit(){
    if (this.state.edit_name){
      return(
        <TagModalForm
          tag={this.props.tag}
          toggleNameForm={this.toggleNameForm}
          handleUpdateTag={this.props.handleUpdateTag}
        ></TagModalForm>
      );  
    }
    else{
      return(
        <span>
          <h4>{this.props.tag.name}</h4>
          <span onClick={this.toggleNameForm} className="btn btn-sm glyphicon glyphicon-pencil"></span>
        </span>
      );
    }
  },
  
  render(){
    var tag = this.props.tag;
    return(
      <div className="row well tag">
        <div className="col-md-5">
          <h4>
            {this.tagNameOrEdit()}
          </h4>
        </div>
        <div className="col-md-3">
          {"Tasks: " + tag.tasks}
        </div>
        <div className="col-md-4">
          <div className="pull-right">
            <a href="javascript: void(0)" onClick={this.delete} className="delete btn btn-danger">
              <span className="glyphicon glyphicon-trash"></span>
            </a>
          </div>
        </div>
      </div>
    );
  }
  
});