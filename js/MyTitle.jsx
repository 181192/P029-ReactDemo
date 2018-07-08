import React from 'react';
import PropTypes from 'prop-types';

const MyTitle = props => {
  const { title, color } = props;
  return (
    <div>
      <h1 style={{color}}>
        {title}
      </h1>
    </div>
  );
};

MyTitle.propTypes = {
  title: PropTypes.string.isRequired,
  color: PropTypes.string.isRequired
};

export default MyTitle;
