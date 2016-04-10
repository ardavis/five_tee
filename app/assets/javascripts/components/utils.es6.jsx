function get(path){
  $.ajax({
    type: "GET",
    url: path,
    dataType: 'json',
    success: function(data){
      alert(data);
      return data;
    }
  });
}

//
// function _fetch(url, options) {
//   return fetch(url, options)
//     .then(response=>{
//       return response.json();
//     })
//     .catch(err=>{
//       console.log('There was an error processing your request');
//       console.log(err);
//     });
// }
//
// function get(url, options={}) {
//
//   const defaultOptions = {
//     headers: {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json'
//     }
//   };
// }