var TagForm = React.createClass({

  getInitialState(){
    return({
      tagInput: false
    });
  },

  toggleTagInput(){
    this.setState({tagInput: !this.state.tagInput});
  },

  tagDropdownOrInput(){
    if (this.state.tagInput){
      return(
        <TagInput
          task={this.props.task}
          toggleTag={this.props.toggleTag}
          toggleTagInput={this.toggleTagInput}
          handleUpdateTask={this.props.handleUpdateTask}
          setFlash={this.props.setFlash}
        ></TagInput>
      );
    }
    else{
      return(
        <TagDropdown
          task={this.props.task}
          tags={this.props.tags}
          toggleTag={this.props.toggleTag}
          toggleTagInput={this.toggleTagInput}
          handleUpdateTask={this.props.handleUpdateTask}
        ></TagDropdown>
      );
    }
  },


  render(){
    return(
      <div>
        {this.tagDropdownOrInput()}
      </div>
    );
  }


});