import paths from 'main/paths'

// const patterns = {
//   id: ':id(\\d+)'
// }

const routingPaths = {
  indexPath:
    paths.rootPath,

  // feedPath:
  //   paths.feedPath(patterns.id)
}

export default Object.assign({}, ...Object.keys(routingPaths).map(
  key => ({ [key]: unescape(routingPaths[key]) })
))
