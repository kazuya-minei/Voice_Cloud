const { environment } = require('@rails/webpacker')

const webpack = require('webpack')    //jQueryを管理下として認定
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/src/jquery',
        jQuery: 'jquery/src/jquery'
    })
)

module.exports = environment
