require! <[fs fs-extra imagemin imagemin-pngquant]>
pngmin = imagemin-pngquant speed: 1, strip: true, quality: [0.3, 0.5], posterize: 4

fs-extra.ensure-dir-sync './png-min/'
files = fs.readdir-sync '../png/' .map -> [it, "../png/#it"]
promises = files.map (file) -> 
  buffer = fs.read-file-sync file.1
  pngmin(buffer)
    .then (output) -> fs.write-file-sync "png-min/#{file.0}", output 

Promise.all promises .then -> console.log \done.
