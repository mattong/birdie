const webpack = require('webpack')
const resolve = require('path').resolve
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')
const LiveReloadPlugin = require('webpack-livereload-plugin')

const DEBUG = process.env.NODE_ENV !== 'production'
const SRC = '.'
const DEST = '../priv/static'

module.exports = {
  cache: true,

  context: __dirname,

  entry: {
    // JavaScript
    'js/app': `${SRC}/js/app.js`,

    // CSS
    'css/app': `${SRC}/css/app.js`
  },

  output: {
    path: resolve(__dirname, DEST),
    filename: '[name].js',
    pathinfo: DEBUG ? true : false,
    devtoolModuleFilenameTemplate: 'webpack:///[absolute-resource-path]'
  },

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: DEBUG
          ? ExtractTextPlugin.extract({
            fallback: 'style-loader',
            use: ['css-loader?-url&sourceMap&importLoaders=1', 'postcss-loader?sourceMap=inline', 'sass-loader?sourceMap']
          })
          : ExtractTextPlugin.extract({
            fallback: 'style-loader',
            use: ['css-loader?-url', 'postcss-loader', 'sass-loader']
          })
      },
      {
        test: /\.(js)$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        options: {
          presets: ['env'],
          cacheDirectory: true
        }
      },
      {
        test: /\.(eot|svg|ttf|woff|woff2)$/,
        loader: 'file-loader'
      }
    ]
  },

  plugins: [
    // Delete old files when compiling
    new CleanWebpackPlugin([ DEST ]),

    // Extract to .css
    new ExtractTextPlugin({
      filename: '[name].css',
      allChunks: true // preserve source maps
    }),

    // Compress React (and others)
    new webpack.EnvironmentPlugin({
      NODE_ENV: 'development'
    }),

    // Copying files directly
    new CopyWebpackPlugin([
      { from: `${SRC}/images`, to: './images' },
      { from: `${SRC}/html`, to: '.' },
    ]),
  ].concat(DEBUG ? [
    // LiveReload in development
    new LiveReloadPlugin({
      appendScriptTag: true
    }),

    // Debug mode for old webpack plugins
    new webpack.LoaderOptionsPlugin({
      debug: true
    })
  ] : []),

  // Hide source maps in production (no sourceMappingURL)
  devtool: DEBUG ? 'source-map' : 'hidden-source-map',

  // https://github.com/webpack-contrib/extract-text-webpack-plugin/issues/35
  stats: stats(),

  devServer: {
    stats: stats()
  },
}

function stats () {
  return {
    children: false,
    chunks: false,
    assetsSort: 'name',
  }
}
