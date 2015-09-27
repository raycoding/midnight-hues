app.factory('ScribbleList', function(){
  data = [
    { description: 'Setup a basic Todo List App in Angular', done: true, snippet: 'App name Scribbles, simple Todo list' },
    { description: 'Stying and CSS', done: false, snippet: 'Bootstrap and Fontwawsome! How about making it responsive?' },
    { description: 'NodeJS Server', done: false, snippet: 'Setup the Server..' },
    { description: 'Models and MongoDB database', done: false, snippet: 'Integrate with DB' },
    { description: 'More Stuffs', done: false, snippet: '..Add a note..' },
    { description: 'Add more Services!', done: false, snippet: '..Add a note..' },
    { description: 'Integrate features!', done: false, snippet: '..Add a note..' },
    { description: 'Production ready', done: false, snippet: 'How about Google Play?' },
    { description: 'Finishing touches', done: false, snippet: 'Completed!' },
  ];
  return data;
});