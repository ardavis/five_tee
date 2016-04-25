var NewTaskTagForm = React.createClass({

  getInitialState(){
    return({
      tagInput: false
    });
  },
  
  handleTagSelect(tag){
    this.setState({tag: tag});
  },

  toggleTagInput(){
    this.setState({tagInput: !this.state.tagInput});
    this.props.setFlash(null);
  },

  handleNewTag(params){
    this.props.handleNewTag(params, this)
  },
  
  tagDropdownOrInput(){
    if (this.state.tagInput){
      return(
        <NewTaskTagInput
          toggleTagInput={this.toggleTagInput}
          handleNewTag={this.handleNewTag}
          setFlash={this.props.setFlash}
          handleTagSelect={this.handleTagSelect}
        ></NewTaskTagInput>
      );
    }
    else{
      return(
        <NewTaskTagDropdown
          tags={this.props.tags}
          tag={this.state.tag}
          toggleTagInput={this.toggleTagInput}
          handleTagSelect={this.handleTagSelect}
        ></NewTaskTagDropdown>
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