import React from 'react';

const ce = React.createElement;

const MyTitle = function () {
  return (
    ce('div', null,
      ce('h1', {style: {color: 'blue'}}, 'Test')
    )
  );
};

export default MyTitle;
