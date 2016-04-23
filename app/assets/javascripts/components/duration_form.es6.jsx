var DurationForm = React.createClass({

  componentDidMount(){
    duration = durationParse(this.props.current_duration);
  },

  render(){

    return(
      <span>
        <input className="form duration"></input>
        <span> hr </span>
        <input className="form duration"></input>
        <span> min </span>
        <input className="form duration"></input>
        <span> sec </span>
      </span>
    );

  }

});