var TagModal = React.createClass({

  componentDidMount(){
    var hideTagModal = this.props.hideTagModal;
    $('.tag.modal').modal('toggle');
    $('.tag.modal').on('hidden.bs.modal', function (e) {
      hideTagModal();
    });
  },

  tagRows(){
    var handleTagDelete = this.props.handleTagDelete;
    var handleUpdateTag = this.props.handleUpdateTag;
    var updateTag = this.props.updateTag;
    var setFlash = this.props.setFlash;
    rows = [];
    this.props.tags.forEach(function(tag){
      rows.push(
        <Tag
          key={tag.id}
          tag={tag}
          handleTagDelete={handleTagDelete}
          updateTag={updateTag}
          handleUpdateTag={handleUpdateTag}
          setFlash={setFlash}
        ></Tag>
      );
    });
    if (rows.length > 0){
      return rows;
    }
    else{
      return <h4>You have no tags</h4>
    }
  },

  flashDisplay(){
    if (this.props.flash){
      return(
        <div className="alert alert-danger">{this.props.flash}</div>
      )
    }
  },


  render(){
    return(
      <div className="tag modal fade" role="dialog">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <h4>Manage Tags</h4>
            </div>
            <div className="modal-body">
              {this.flashDisplay()}
              <div className="tag_container">
                {this.tagRows()}
              </div>
            </div>
            <div className="modal-footer">
              <span><a className="btn btn-default" href="javascript: void(0)" data-dismiss="modal">Close</a></span>
            </div>
          </div>
        </div>
      </div>
    )
  }



});