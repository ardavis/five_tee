var ArchivesIndex = React.createClass({

  getInitialState(){
    return(
      {archives: this.props.archives}
    );
  },

  archiveRows(){
    rows = [];
    this.state.archives.forEach(function(archive){
      rows.push(<Archive key={archive.id} archive={archive}></Archive>)
    });
    return rows.length == 0 ? <h4>You don't have any archives</h4> : rows;
  },

  render(){
    return(
      <div>
        <ArchivesHeader></ArchivesHeader>
        <div className="container">
          <h1>Archives:</h1>
          {this.archiveRows()}
        </div>
      </div>
    );
  }

});