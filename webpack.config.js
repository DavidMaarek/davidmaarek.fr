const path = require("path"),
      miniCssExtractPlugin = require('mini-css-extract-plugin');

const inPutPath = './assets/',
      inPutPathJs = inPutPath + 'js/',
      inPutPathCss = inPutPath + 'css/',
      inPutPathImages = inPutPath + 'images/';

const outPutPath = './public/',
      outPutPathJs = outPutPath + 'js/',
      outPutPathCss = outPutPath + 'css/',
      outPutPathImages = outPutPath + 'images/',
      outPutPathFonts = '../fonts/';

const { isProduction } = require('webpack-mode');

const jsConf = {
  entry: inPutPathJs + 'main.js',
  output: {
    path: path.resolve(__dirname, outPutPathJs),
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader",
          options: {
            presets: ['@babel/preset-env'],
          },
        }
      },
    ]
  }
};

const cssConf = {
  entry: inPutPathCss + 'main.scss',
  output: {
    path: path.resolve(__dirname, outPutPathCss),
  },
  module: {
    rules: [
      {
        test: /\.scss$/,
        exclude: /node_modules/,
        use: [
          {
            loader: miniCssExtractPlugin.loader,
            options: {

            }
          },
          { loader: "css-loader" },
          { loader: "sass-loader" }
        ]
      },
      {
        test: /\.(woff(2)?|ttf|eot|svg)(\?v=\d+\.\d+\.\d+)?$/,
        use: [
          {
            loader: 'file-loader',
            options: {
              name: '[name].[ext]',
              outputPath: outPutPathFonts
            }
          }
        ]
      }
    ]
  },
  plugins: [
    new miniCssExtractPlugin({
      filename: '[name].css',
      chunkName: '[id].css'
    })
  ]
};

module.exports = [jsConf, cssConf];
