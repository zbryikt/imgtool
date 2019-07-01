require! <[fs imagemin imagemin-gifsicle imagemin-giflossy]>

order = ["vanilla","stripe","sparkling","firework","gradient","lava","rainbow","stripe-3d","confetti","crystal","marble","speedline","explodeline","flower","heart","pop-circle","isometric","three","noise","spinner",["spinner","sunny"], ["spinner","sync"],["noise","wire"], "pattern", "scratch", "distort", "light"]

#gifmin = imagemin-gifsicle({optimizationLevel: 3, colors: 64})
gifmin = imagemin-giflossy({optimizationLevel: 3, colors: 32, lossy: 200})
#files = fs.readdir-sync '../gif/' .map -> [it, "../gif/#it"]
files = order.map -> 
  if Array.isArray(it) => it = it.1
  [it, "../gif/#it.gif"]

promises = files.map (file) -> 
  buffer = fs.read-file-sync file.1
  gifmin(buffer)
    .then (output) -> fs.write-file-sync "out/#{file.0}", output 

Promise.all promises .then -> console.log \done.
