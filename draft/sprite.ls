require! <[fs fs-extra sharp canvas imagemin-pngquant]>

pngmin = imagemin-pngquant speed: 1, strip: true, quality: [0.6, 0.9]

files = fs.readdir-sync '../png/'
  .filter -> /\.png$/.exec it
  .map -> [it, "../png/#it"]

order = ["vanilla","stripe","sparkling","firework","gradient","lava","rainbow","stripe-3d","confetti","crystal","marble","speedline","explodeline","flower","heart","pop-circle","isometric","three","noise","spinner",["spinner","sunny"], ["spinner","sync"],["noise","wire"], "scratch", "distort", "light"]

files = order.map -> 
  if Array.isArray(it) => it = it.1
  [it, "../png/#it.png"]

options = do
  width: 900, height: 170 * Math.ceil(files.length / 2), channels: 4,
  background: {r: 255, g: 255, b: 255, alpha: 0}

c = canvas.createCanvas options.width, options.height
ctx = c.getContext \2d

promises = files.map (file, i) ->
  canvas.loadImage file.1
    .then -> ctx.drawImage it, ((i % 2) * 450), Math.floor(i/2) * 170, 450, 170

Promise.all promises
  .then -> pngmin(c.toBuffer \image/png)
  .then -> fs.write-file-sync "sprite.png", it 
  .then -> console.log \done.



/*

require! <[fs sharp]>
files = fs.readdir-sync '../png/' .map -> [it, "../png/#it"]

options = do
  width: 900, height: 170 * Math.ceil(files.length / 2), channels: 4,
  background: {r: 255, g: 255, b: 255, alpha: 0}

output = sharp({ create: options }).raw!.toBuffer!

idx = 0
ret = files.reduce(((a, b) ->
  ret = a.then ->
    sharp(it, options)
      .overlayWith(b.1, { left: ((idx % 2) * 450), top: Math.floor(idx/2) * 170 })
      .raw!.toBuffer!
  idx := idx + 1
  return ret
), output)

ret.then -> sharpt(it, options).toFile("sprite.png")
   .then -> console.log \done.
*/

/*
promises = files.map (file, i) ->
  console.log i, { left: ((i % 2) * 450), top: Math.floor(i/2) * 170 }
  output.overlayWith(file.1, { left: ((i % 2) * 450), top: Math.floor(i/2) * 170 })

Promise.all promises
  .then -> output.toFile('sprite.png')
  .then -> console.log \done.
*/
