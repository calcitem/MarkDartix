const { GitRevisionPlugin } = require('git-revision-webpack-plugin')
const { version } = require('../package.json')

const getEnvironmentDefinitions = function () {
  let shortHash = 'N/A'
  let fullHash = 'N/A'
  try {
    const gitRevisionPlugin = new GitRevisionPlugin()
    shortHash = gitRevisionPlugin.version()
    fullHash = gitRevisionPlugin.commithash()
  } catch(_) {
    // Ignore error if we build without git.
  }

  const isStableRelease = !!process.env.MARKDARTIX_IS_STABLE
  const versionSuffix = isStableRelease ? '' : ` (${shortHash})`
  return {
    'global.MARKDARTIX_GIT_SHORT_HASH': JSON.stringify(shortHash),
    'global.MARKDARTIX_GIT_HASH': JSON.stringify(fullHash),

    'global.MARKDARTIX_VERSION': JSON.stringify(version),
    'global.MARKDARTIX_VERSION_STRING': JSON.stringify(`v${version}${versionSuffix}`),
    'global.MARKDARTIX_IS_STABLE': JSON.stringify(isStableRelease)
  }
}

const getRendererEnvironmentDefinitions = function () {
  const env = getEnvironmentDefinitions()
  return {
    'process.versions.MARKDARTIX_VERSION': env['global.MARKDARTIX_VERSION'],
    'process.versions.MARKDARTIX_VERSION_STRING': env['global.MARKDARTIX_VERSION_STRING'],
  }
}

module.exports = {
  getEnvironmentDefinitions: getEnvironmentDefinitions,
  getRendererEnvironmentDefinitions: getRendererEnvironmentDefinitions
}
