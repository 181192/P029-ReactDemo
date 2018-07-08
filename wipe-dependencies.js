const fs = require('fs');

const wipeDependencies = () => {

  const file  = fs.readFileSync('package.json')
  const content = JSON.parse(file)

  const [ devDependencies ] = content.devDependencies;
  const [ dependencies ] = content.dependencies;

  Object.keys(devDependencies).forEach( (devDep) => {
    if (!devDependencies[devDep].includes("git"))
      devDependencies[devDep] = '*'
  })

  Object.keys(dependencies).forEach( (dep) => {
    if (!dependencies[dep].includes("git"))
      dependencies[dep] = '*'
  })

  fs.writeFileSync('package.json', JSON.stringify(content))
}

if (require.main === module) wipeDependencies()
else module.exports = wipeDependencies
