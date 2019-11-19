require! <[fs imagemin imagemin-gifsicle imagemin-giflossy]>

gifsicle = imagemin-gifsicle({optimizationLevel: 3, colors: 128})
giflossy-light = imagemin-giflossy({optimizationLevel: 3, colors: 64, lossy: 35})
giflossy-heavy = imagemin-giflossy({optimizationLevel: 3, colors: 64, lossy: 200})

name = process.argv.2
if !name =>
  console.log "usage: gifmin [filename]"
  process.exit!


buffer = fs.read-file-sync name
gifsicle(buffer)
  .then (output) ->
    fs.write-file-sync name.replace(/\.(.*)$/,'.min.$1'), output 
    giflossy-light(buffer)
  .then (output) ->
    fs.write-file-sync name.replace(/\.(.*)$/,'.lossy.light.min.$1'), output
    giflossy-heavy(buffer)
  .then (output) ->
    fs.write-file-sync name.replace(/\.(.*)$/,'.lossy.heavy.min.$1'), output
