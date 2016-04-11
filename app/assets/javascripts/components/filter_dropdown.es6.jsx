class FilterDropdown extends React.Component {

  constructor(props){
    super(props);
    this.state = {tags, filter} = this.props;
  }

  render(){
    console.log("filter render");
    console.log(this.state);
    tags = this.state.tags;
    filter_label = this.state.filter.label;

    filter_list_items = [];
    tags.forEach(function (tag){
      list_item = <li key={tag.id}><a href="#" className="filter_link" value={tag.id}>{tag.name}</a></li>;
      filter_list_items.push(list_item);
    });


    return(
      <div className="dropdown">
        <span>Filter by:</span>
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button" id="filter_dropdown">
          <span>{filter.label}</span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          <li>
            <a href="#" className="filter_link">All Tags</a>
          </li>
          <li>
            <div className="divider"></div>
          </li>
          {filter_list_items}
        </ul>
      </div>
    );
  }
}