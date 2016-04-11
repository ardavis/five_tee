class SortDropdown extends React.Component {

  constructor(props){
    super(props);
    this.state = {filter_sort, sort_options} = this.props;
  }

  render(){
    sort_options = this.props.sort_options;
    sort_label = this.props.filter_sort.sort.label;
    
    sort_list_items = [];
    sort_options.forEach(function (list_item){
      list_item = <li key={list_item.sql}><a href="#" className="sort_link" value={list_item.sql}>{list_item.label}</a></li>;
      sort_list_items.push(list_item);
    });


    return(
      <div className="dropdown">
        <span>Sort by:</span>
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button" id="sort_dropdown">
          <span>{sort_label}</span>
          <span className="caret"></span>
        </button>
        <ul className="dropdown-menu">
          {sort_list_items}
        </ul>
      </div>
    );
  }
}