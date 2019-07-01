require! <[fs fs-extra imagemin imagemin-pngquant]>
pngmin = imagemin-pngquant speed: 1, strip: true, quality: [0.7, 0.8] #, posterize: 4

name = process.argv.2
if !name =>
  console.log "usage: gifmin [filename]"
  process.exit!

buffer = fs.read-file-sync name
pngmin(buffer)
  .then (output) -> fs.write-file-sync "#{name.replace /\.png/, '.min.png'}", output 

