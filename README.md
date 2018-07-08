# P029-ReactDemo

React demo app for testing different tools in react development.
Running everything in a multi-stage docker build with an extreme light Linux
Alpine with Nodejs image of only 69,9MB with all the node modules the final size
is 115MB for the whole container versus 673MB for the original NodeJs 8 docker
image!

Where docker is first building a base image a copy of all packages.json files.
Then it's installing all the dependencies including the dev dependencies in a
dependencies container. The production dependencies is being copied in a
separate folder for later use. After that I have a test container where the
application code + the dependencies (from dependencies container ) is being
copied and all the tests is being run.

After that it's the release container where I do the final copy of the
application code and use the production dependencies from the dependencies
container.
The final container can be run by docker compose with the simple command:
`docker-compose up`

For building the application code I use ESLint for syntax rules, Babelrc for
ES6 compiling and webpack for building the app bundle `bundle.js` for serving
the app.

And I also use Yarn as package manager that is a much simpler package manager
versus NPM, and also have up to 10X the reduction in install times with big
code bases. Yarn is 100% deterministic, so you can run Yarn from any state you
want and it will always return the same.
