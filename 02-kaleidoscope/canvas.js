const canvas = document.querySelector('div.canvas-holder canvas')
const sandbox = new GlslCanvas(canvas)

//load glsl code
fetch('fragment.glsl')
    .then(response => response.text())
   .then(text => sandbox.load(text))


sandbox.setUniform('image', 'artwork1.jpeg')