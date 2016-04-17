class TagDropdown extends React.Component{
  constructor(props){
    super(props);
  }


  tag_list(){
    tag_rows = [];
    tags.forEach(function (tag){
      tag_row = <li key={tag.id}><a className="select_tag" href="#" value={`/tags/${tag.id}/select`}>{tag.name}</a></li>;
      tag_rows.push(tag_row);
    });
    return tag_rows;
  }


  
  render(){
    selected_tag = this.props.selected_tag;
    return(
      <div className="dropdown">
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button" id="sort_dropdown">
          <span className="task_form_tag" value={selected_tag.id}>{selected_tag.name}</span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          <li>
            <a className="create_new_tag" href="#">Create New Tag</a>
          </li>
          <li><div className="divider"></div></li>
          <li><a className="select_no_tag" href="#">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
          {this.tag_list()}
        </ul>
      </div>
    );
      
  }
}