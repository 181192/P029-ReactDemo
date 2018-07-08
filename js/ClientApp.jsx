import React from 'react';
import ReactDOM from 'react-dom';
import MyTitle from './MyTitle';

const MyFirstComponent = function() {
  return (
    <div>
      <MyTitle title="Props are great!" color="rebeccapurple" />
      <MyTitle title="Use props everywhere!" color="mediumaquamarine" />
      <MyTitle title="Props are the best!" color="peru" />
    </div>
  );
};

ReactDOM.render(<MyFirstComponent />, document.getElementById('app'));
