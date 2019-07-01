require! <[imagemin imagemin-giflossy]>
gifmin = imagemin-giflossy({optimizationLevel: 3, colors: 32, lossy: 200})
module.exports = gifmin
