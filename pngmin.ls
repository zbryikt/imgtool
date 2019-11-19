require! <[fs fs-extra imagemin imagemin-pngquant progress colors]>
pngmin = imagemin-pngquant speed: 1, strip: true, quality: [0.7, 0.8] #, posterize: 4

name = process.argv.2
des = process.argv.3
if !name =>
  console.log "usage: gifmin [filename] [output]"
  process.exit!

progress-bar = (total = 10, text = "converting") ->
  bar = new progress(
    "   #text [#{':bar'.yellow}] #{':percent'.cyan} :etas",
    { total: total, width: 60, complete: '#' }
  )
  return bar

if fs.stat-sync name .is-directory! =>
  files = fs.readdir-sync name .map -> "#name/#it"
  bar = progress-bar files.length
  _ = (list) ->
    item = list.splice 0, 1 .0
    if !item => return console.log "done."
    buffer = fs.read-file-sync item
    pngmin(buffer)
      .then (output) ->
        bar.tick!
        fs.write-file-sync "#item", output
        setTimeout (-> _ list), 10
  _ files
else
  buffer = fs.read-file-sync name
  pngmin(buffer)
    .then (output) -> fs.write-file-sync (if des => des else ("#{name.replace /\.png/, '.min.png'}")), output 

