class SortDropdown extends React.Component{

  constructor(props){
    super(props);
    this.state = {sort, sort_options} = this.props;
  }

  render(){
    sort_options = this.state.sort_options;
    sort_label = this.state.sort.label;


    sort_list_items = [];
    id = 1;
    sort_options.forEach(function (option){
      list_item = <li key={id}><a href="#" className="sort_link" value={option.sql}>{option.label}</a></li>;
      sort_list_items.push(list_item);
      id++;
    });

    return(
      <div className="dropdown">
        <span>Sort by:</span>
        <button className="btn btn-secondary dropdown-toggle" data-toggle="dropdown" type="button" id="filter_dropdown">
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

